class UsersController < ApplicationController
  before_action :authenticate_user!,  :except => [:register, :login, :license]

  def register
  end

  def login
  end

  def license
    render 'shared/_license'
  end

  def show
    @user = User.find(params[:id])
    authorize @user, :show?
  end

  def update

    if params[:user].has_key?(:avatar)
      current_user.avatar.purge
      current_user.avatar.attach(params[:user][:avatar])
    end
    current_user.update(user_params.except(:avatar))
    
    redirect_to home_index_path

  end

  def user_params
      params.require(:user).permit(:name, :email, :password, :avatar)
  end

end
