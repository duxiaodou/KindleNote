class NotesController < ApplicationController
  def index
  end

  def show
    @note = Note.find(params[:id])
  end
end
