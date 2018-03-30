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
  post 'run_encor_dividend', to: 'jobs#run_encor_dividend'
  get '/run_encor_service_finance/:id', to: 'jobs#run_encor_service_finance', as: 'run_encor_service_finance'
end
