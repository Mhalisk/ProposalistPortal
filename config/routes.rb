Rails.application.routes.draw do
  
  resources :jobs
  get 'encor_jobs', to: 'jobs#list_encor_jobs'
  devise_for :users
  get 'pages/home'
  root to: 'pages#home'

  # Encor Solar Routes
  
  get 'encor_solar/home'

end
