TemplateNew::Application.routes.draw do

  resources :sessions
  resources :networks
  resources :vlans
  resources :activos
  resources :sips
  resources :tags

  match 'dashboard' => 'dashboard#index', :as => :dashboard
  match 'user/edit' => 'sessions#edit', :as => :edit_current_user
  match 'logout' => 'sessions#destroy', :as => :logout
  match 'login' => 'sessions#new', :as => :login
  match 'update' => 'sessions#update', :as => :update
  match 'search' => 'search#index', :as => :search
  match 'search_print' => 'search#print', :as => :search_print
  match 'switch_status' => 'networks#switch_status', :as => :switch_status
  match 'resolv' => 'networks#resolv', :as => :resolv

	put 'taxonomy/:id' => 'taxonomy#update#id'
  post 'taxonomy' => 'taxonomy#create', :as => :taxontypes
  match 'taxonomy/new' => 'taxonomy#new'
  match 'taxonomy/show/:id' => 'taxonomy#show#id'
	match 'taxonomy/delete/:id' => 'taxonomy#delete#id'
	match 'taxonomy/edit/:id' => 'taxonomy#edit#id'
  match 'taxonomy' => 'taxonomy#index'



  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'
  root :to => "dashboard#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
