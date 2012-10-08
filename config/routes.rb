Lndry::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  root :to => 'resources#index'
  match '/index',     :method => :get,  :controller => :resources,  :action => :index,      :as => :index
  match '/letmeknow', :method => :post, :controller => :resources,  :action => :letmeknow,  :as => :letmeknow
  match '/receive',   :method => :post, :controller => :resources,  :action => :receive
  match '/api',                         :controller => :content,    :action => :api,        :as => :api
  resources :resources
end
