class PermissionsController < ApplicationController
  def index
  end

  def new
    @permission = Permission.new
  end

  def create
    @permission = Permission.create! permission_params
    redirect_to permission_path(@permission)
  end

  def show
    @permission = Permission.find(params[:id])
  end

  def permission_params
      params.require(:permission).permit(:name, :title)
  end

end
