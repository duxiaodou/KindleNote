Rails.application.routes.draw do
  get 'permissions/index'
  scope "/:locale" do
    get 'fragments/index'
    get 'books/index'
    get 'notes/index'
    get 'home/index', as: 'home'

    devise_for :users, controllers: { registrations: 'users/registrations', sessions:  "users/sessions"}

    get 'welcome/index'

    get 'license',      to: 'users#license'

    get 'clippings',  to: 'clippings#new'
    post 'clippings',  to: 'clippings#create'
    patch 'clippings', to: 'clippings#parse', as: 'cliping_parse'

    resources :users
    resources :roles do 
      post 'permissions', to: 'permissions#attach_permissions', as: 'attach_permissions'
      delete 'permissions', to: 'permissions#detach_permissions', as: 'detach_permissions'
      post 'users', to: 'permissions#attach_users', as: 'attach_users'
      delete 'users', to: 'permissions#detach_users', as: 'detach_users'
    end
    resources :permissions
    resources :books
    resources :notes do
      post 'share', to: 'notes#share', as: 'share'
    end

    resources :users do
      resources :notes
    end

    resources :books do
      resources :notes
    end

    scope 'oauth' do
      scope 'evernote' do
          get 'authorize',     to: 'oauth/evernote#authorize', as: 'evernote_authorize'
          get 'callback',      to: 'oauth/evernote#callback', as: 'evernote_callback'
          get 'revoke',     to: 'oauth/evernote#revoke', as: 'evernote_revoke'
      end

      scope 'qq' do
        get 'authorize',     to: 'oauth/qq#authorize', as: 'qq_authorize'
        get 'callback',      to: 'oauth/qq#callback', as: 'qq_callback'
        get 'revoke',     to: 'oauth/qq#revoke', as: 'qq_revoke'
      end

      scope 'youdao' do
        get 'authorize',     to: 'oauth/youdao#authorize', as: 'youdao_authorize'
        get 'callback',      to: 'oauth/youdao#callback', as: 'youdao_callback'
        get 'revoke',     to: 'oauth/youdao#revoke', as: 'youdao_revoke'
      end

      scope 'weibo' do
        get 'authorize',     to: 'oauth/weibo#authorize', as: 'weibo_authorize'
        get 'callback',      to: 'oauth/weibo#callback', as: 'weibo_callback'
        get 'revoke',     to: 'oauth/weibo#revoke', as: 'weibo_revoke'
      end
    end
  end
  get '/:locale' => 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
end
