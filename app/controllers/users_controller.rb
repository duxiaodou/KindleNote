class UsersController < ApplicationController
  before_action :authenticate_user!,  :except => [:register, :login, :license]

  def register
  end

  def login
  end

  def license
    render 'shared/_license'
  end

end
