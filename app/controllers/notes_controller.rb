require Rails.root.join('app/serves/cloud_note_server_factory.rb')

class NotesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @notes = Note.page(params[:page])

  end

  def show
    @note = Note.find(params[:id])
  end

  def share
    note = Note.find(params[:note_id])
    begin
      serve = CloudNoteServeFactory.createNoteServe(params[:platform], current_user, note)
      if serve.create
        flash[:success] = "已成功笔记分享到#{params[:platform]}"
      else
        flash[:success] = "分享笔记到#{params[:platform]}失败"
      end
    rescue NotImplementedError => error
      flash[:error] = error.to_s
    rescue  => error
      flash[:error] = error.to_s
    end

    redirect_to note_path(note)
  end
end
