Rails.application.routes.draw do




  devise_for :people, controllers:{omniauth_callbacks: 'omniauth'}
  root 'posts#index',as: "home"

  get 'sec' => 'pages#name'
  resources :posts do
   resources :comments
  end
  resources :people, only: [:show,:edit,:update]


end
