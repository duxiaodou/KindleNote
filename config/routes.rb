Rails.application.routes.draw do
  devise_for :users
  get 'welcome/index'
  get 'register',         to: 'users#register'
  get 'login',         to: 'users#login'
  get 'license',      to: 'users#license'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
end
