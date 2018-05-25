Rails.application.routes.draw do
  get 'home/index'
  devise_for :users, :controllers => {:registrations => "users/registrations"}

  get 'welcome/index'

  get 'license',      to: 'users#license'

  get 'clippings',  to: 'clippings#new'
  post 'clippings',  to: 'clippings#create'

  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
end
