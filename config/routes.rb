Rails.application.routes.draw do
  get 'game/init'

  namespace :admin do
    get 'index/index'
  end

  devise_for :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
