require 'evernote_oauth'

class Oauth::EvernoteController < ApplicationController

    include UsersHelper
    
    before_action :authenticate_user!,  :except => [:authorize, :callback ]

    def authorize
        callback_url = request.url.chomp("authorize").concat("callback")
        if params[:oauth_verifier]
            access_token = session[:request_token].get_access_token(oauth_verifier: params[:oauth_verifier])
            session[:access_token] = access_token.token
            redirect_to root_path
        else
            client = EvernoteOAuth::Client.new
            session[:request_token] = client.request_token(:oauth_callback => callback_url)
            redirect_to session[:request_token].authorize_url
        end
    end
        

    def callback
        consumer = EvernoteOAuth::Client
        request_token = OAuth::RequestToken.new(consumer, session[:request_token], session[:request_token_secret])

        token = session[:request_token].get_access_token(oauth_verifier: params[:oauth_verifier])
        access_token = token.token
        access_token_expires = token.params['edam_expires']


        user_store = EvernoteOAuth::Client.new(token: access_token).user_store
        evernote_user = user_store.getUser
        

        evernote_accessToken = AccessToken.find_by(name: 'evernote', openid: evernote_user.id)

        if user_signed_in?
            # 更新绑定的Evernote
            if !evernote_accessToken.nil?
                flash[:success] = "已重新绑定Evernote"
                evernote_accessToken.update(user: current_user, name: 'evernote', title: evernote_user.username, access_token: access_token, openid: evernote_user.id, expires: Time.at(access_token_expires.to_i / 1000), revoked:true )
            else
                # 新绑定Evernote
                flash[:success] = "绑定Evernote成功"
                current_user.access_tokens.create(user: current_user, name: 'evernote', title: evernote_user.username, access_token: access_token, openid: evernote_user.id, expires: Time.at(access_token_expires.to_i / 1000), revoked:true )
            end
            return redirect_to home_path
        else
            # 旧用户登录
            if !evernote_accessToken.nil?
                flash[:success] = "使用Evernote登录成功"
                sign_in evernote_accessToken.user
            else
                flash[:success] = "注册成功，请及时设置您的邮箱和密码"
                new_user = User.create(name: evernote_user.username, password_digest: 'kindlenote')
                new_user.access_tokens.create(user: new_user.id, name: 'evernote', access_token: access_token, openid: evernote_user.id, expires: Time.at(access_token_expires.to_i / 1000), revoked:true )
                sign_in new_user
            end
        end
        redirect_to home_path
    end

    def revoke
        evernote_accessToken = authorization('evernote')
        evernote_accessToken.delete if evernote_accessToken
        flash[:success] = "您已与该Evernote账号解除绑定"
        redirect_to home_path
    end

end