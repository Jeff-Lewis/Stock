StockServer::Application.routes.draw do
  resources :profiles


  resources :beat_misses


  devise_for :users, :path => "auth", :path_names => { :sign_in => 'login', :sign_out => 'logout', :password => 'secret',
        :confirmation => 'verification', :unlock => 'unblock', :sign_up => 'cmon_let_me_in' }
  #, :controllers => {:registrations => "registrations"}

  resources :users

  resources :details


  resources :exchanges


  resources :erdates


  resources :popularities


  resources :stocks

  root :to => 'stocks#index'

  match 'parse' => 'erdates#parse'
  match 'parseErEst' => 'erdates#parseErEst'
  match 'getNextErs' => 'erdates#getNextErs'
  match 'getPreviousErs' => 'erdates#getPreviousErs'
  match 'watchEr' => 'erdates#watchEr'
  match 'unwatchEr' => 'erdates#unwatchEr'
  match 'beatEr' => 'erdates#beatEr'
  match 'missEr' => 'erdates#missEr'

  match 'retrieve' => 'details#retrieve'

  namespace :api do
    namespace :v1 do
      devise_scope :user do
        post 'registrations' => 'registrations#create', :as => 'register'
        post 'sessions' => 'sessions#create', :as => 'login'
        delete 'sessions' => 'sessions#destroy', :as => 'logout'
      end
    end
  end

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

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
