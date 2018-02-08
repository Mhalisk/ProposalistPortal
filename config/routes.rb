Rails.application.routes.draw do
  
  resources :jobs
  devise_for :users
  get 'pages/home'
  root to: 'pages#home'

  # Encor Solar Routes
  
  get 'encor_solar/home'

end
