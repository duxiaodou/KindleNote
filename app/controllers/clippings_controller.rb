class ClippingsController < ApplicationController
  before_action :authenticate_user!

  def new
    render 'clippings/new'
  end

  def create
    if params[:user].has_key?(:clipping)
      current_user.clipping.purge
      current_user.clipping.attach(params[:user][:clipping])
    end
  end

  def parse
      if current_user.clipping.attached?
        active_storage_disk_service = ActiveStorage::Service::DiskService.new(root: Rails.root.to_s + '/storage/')
        clippings_path = active_storage_disk_service.send(:path_for, current_user.clipping.blob.key)
        ParseClippingFileToNotesJob.perform_later clippings_path, current_user
        render :json => 'ss'
      end
  end


  def clipping_params
      params.require(:user).permit(:clipping)
  end
end
