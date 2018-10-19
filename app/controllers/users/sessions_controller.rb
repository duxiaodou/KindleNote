# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  prepend_before_action :valify_captcha!, only: [:create]


  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    super
  end

  def valify_captcha!
    unless verify_rucaptcha?
      flash[:secondary] = t 'rucaptcha.invalid'
      return false 
    end
    true
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    params.permit(:user, :password, :_rucaptcha)
    #devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :rucaptcha])
  end
end
