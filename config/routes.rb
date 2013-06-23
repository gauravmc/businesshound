Businesshound::Application.routes.draw do  
  controller :admin do
    get 'admin' => :index
  end
  
  resources :factories, only: :show do
    resources :bulk_supplies, only: [:index, :new] do
      collection do
        post :create
        get :edit
        put :update
        get :fetch_form
      end
    end
  end
      
  resources :stores, only: :show do
    resources :bulk_stocks, only: :new do
      collection do
        post :create
        get :edit
        put :update
        get :fetch_form        
      end
    end
    resources :bulk_supplies, only: [:index, :new] do
      collection do
        post :create
        get :edit
        put :update
        get :fetch_form
      end
    end
    resources :journal_entries, except: :show
    resource :cash_entries
  end

  controller :sessions do
    get  'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end
    
  resources :companies
  
  namespace :admin do
    resources :products do
      collection do
        put :sort
      end
    end
    resources :stores, :factories
  end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root to: 'sessions#new'
end
