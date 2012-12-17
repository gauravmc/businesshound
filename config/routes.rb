Businesshound::Application.routes.draw do  
  controller :admin do
    get 'admin' => :index
  end
  
  controller :factory do
    get 'factory' => :index
  end
      
  controller :sessions do
    get  'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end
    
  resources :companies
  
  namespace :factory do
    resources :supplies
  end
  
  namespace :admin do
    resources :products, :stores, :factories
  end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root to: 'companies#new'
end
