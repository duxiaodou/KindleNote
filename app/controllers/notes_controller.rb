class NotesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @notes = Note.page(params[:page])

  end

  def show
    @note = Note.find(params[:id])
  end
end
