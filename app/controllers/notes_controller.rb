class NotesController < ApplicationController
  before_action :authenticate_user!
  
  def index
  end

  def show
    @note = Note.find(params[:id])
  end
end
