Rails.application.routes.draw do
  
  get 'powerhome_solar/home'

  resources :jobs
  get 'encor_jobs', to: 'jobs#list_encor_jobs'
  get 'powerhome_jobs', to: 'jobs#list_powerhome_jobs'
  devise_for :users
  get 'pages/home'
  root to: 'pages#home'

  # Encor Solar Routes
  
  get 'encor_solar/home'
  get 'encor_start_dividend', to: 'encor_solar#start'

end
