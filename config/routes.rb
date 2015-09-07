Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { :registrations => "registrations",
                                        omniauth_callbacks: 'omniauth_callbacks' }
  # as :user do
  #   get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'    
  #   put 'users/:id' => 'devise/registrations#update', :as => 'user_registration'            
  # end

  root 'home#index'
  resources :user do
    collection do
      get "landing"
      get "dashboard"
      get "keywords"
      get "reports"
      get "setting"
      get "ads_manager"

      get "get_data"
      get "login"
      post "verify_payment"
      get "verify_username"
      post "connect_facebook"
      get "get_fb_token"
      post "disconnect_facebook"
      get "profile"
    end  
  end 
  # get 'user/landing' => 'user#landing'
  # get 'user/dashboard' => 'user#dashboard'
  # get 'user/keywords' => 'user#keywords'
  # get 'user/reports' => 'user#reports'
  # get 'user/setting' => 'user#setting'
  # get 'user/ads_manager' => 'user#ads_manager'
  # get 'user/get_data' => 'user#get_data'
  # get 'user/login' => 'user#login'

  resources :home do
    collection do
      get "get_viralstyle"
      get "get_teechip"
      get "get_represent"

      get "get_top_campaigns"
      get "get_top_graph"
      get "get_top_summary"
      get "get_campaign_details"
    end  
  end  

  resources :payment
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
