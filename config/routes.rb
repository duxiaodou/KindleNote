Rails.application.routes.draw do
  scope "/:locale" do
    get 'fragments/index'
    get 'books/index'
    get 'notes/index'
    get 'home/index', as: 'home'

    devise_for :users, :controllers => {:registrations => "users/registrations"}

    get 'welcome/index'

    get 'license',      to: 'users#license'

    get 'clippings',  to: 'clippings#new'
    post 'clippings',  to: 'clippings#create'
    patch 'clippings', to: 'clippings#parse', as: 'cliping_parse'

    resources :users
    resources :books
    resources :notes

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
