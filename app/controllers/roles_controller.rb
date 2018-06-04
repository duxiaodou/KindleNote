class RolesController < ApplicationController
  def index
    @roles = Role.page(params[:page])
  end

  def new
    @role = Role.new
    @permissions = Permission.all
  end

  def create
    @role = Role.create! role_params
    @permissions = Permission.all

    redirect_to role_path(@role)
  end

  def show
    @role = Role.find(params[:id])
    @permissions = Permission.all

  end

  def update
    @role = Role.find(params[:id])
    permissions = params[:role][:permissions] 
    users = params[:role][:users]

    if permissions
      @role.permissions.replace(Permission::find(params[:role][:permissions].values))
    else 
      @role.permissions.clear
    end

    if users
      @role.users = User::find(params[:role][:users].values)
    else
      @role.users.clear
    end

    if @role.update(role_params.except(:permissions, :users))       
      redirect_to @role
    else
      render 'show'
    end
  end

  def attach_permissions
  end

  def detach_permissions
  end

  def attach_users
  end

  def detach_users
  end

  def role_params
      params.require(:role).permit(:name, :permissions, :users)
  end
end
