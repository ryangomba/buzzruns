Buzzruns::Application.routes.draw do

    root :to => "home#index"

    resources :athletes
    match "athletes/:id/journal" => "athletes#journal"
    match "athletes/:id/journal/:start" => "athletes#journal"
    match "athletes/:id/journal/:start/:end" => "athletes#journal"
    match "athletes/:id/performances" => "athletes#performances"

    # Logged-in Athlete

    match 'my/dashboard' => 'my#dashboard'
    match 'my/journal' => 'my#journal'
    match 'my/performances' => 'my#performances'

    # Performances

    resources :performances
    get "performances/calendar"
    get "performances/year"
    get "performances/season"
    match 'performances/tfrrs/:id' => 'performances#tfrrs_meet'

    # Meets

    resources :meets

    # Events

    resources :events

    # Admin Views

    get "admin/athletes"
    get "admin/milage"
    get "admin/performances"

    # Authentication

    match 'login' => 'sessions#create'
    match 'logout' => 'sessions#destroy'
    get "sessions_path", :to => "sessions#create"
    
    match '/auth/facebook/callback' => 'services#create'
    resources :services, :only => [:index, :create]

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

    # See how all your routes lay out with "rake routes"
    
end
