Businesshound::Application.routes.draw do  
  controller :admin do
    get 'admin' => :index
  end
  
  controller :factory do
    get 'factory' => :index
  end
      
  controller :store do
    get 'store' => :index
  end

  controller :sessions do
    get  'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end
    
  resources :companies
  
  namespace :admin do
    resources :products, :stores, :factories
  end

  namespace :factory do
    resources :supplies do
      collection do
        get :fetch_form
      end
    end
  end
  
  namespace :store do
    resources :stocks do
      collection do
        get :fetch_form
      end
    end
  end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root to: 'sessions#new'
end
