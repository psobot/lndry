Lndry::Application.routes.draw do
  root :to => 'resources#index'
  match '/letmeknow', :method => :post, :controller => :resources, :action => :letmeknow
  resources :resources
end
