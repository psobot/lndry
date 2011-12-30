Lndry::Application.routes.draw do
  root :to => 'resources#index'
  match '/letmeknow', :method => :post, :controller => :resources, :action => :letmeknow
  match '/receive', :method => :post, :controller => :resources, :action => :receive
  resources :resources
end
