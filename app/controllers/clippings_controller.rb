class ClippingsController < ApplicationController
  def new
    render 'clippings/new'
  end

  def create
    if params[:user].has_key?(:clipping)
      current_user.clipping.purge
      current_user.clipping.attach(params[:user][:clipping])
    end
  end


  def clipping_params
      params.require(:user).permit(:clipping)
  end
end
