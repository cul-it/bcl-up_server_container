Rails.application.routes.draw do
  mount Qa::Engine => '/authorities'
  mount BclUpServer::Engine, at: '/'
  resources :welcome, only: 'index'
  root 'bcl_up_server/homepage#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
