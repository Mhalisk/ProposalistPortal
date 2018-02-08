Rails.application.routes.draw do
  
  devise_for :users
  get 'pages/home'
  root to: 'pages#home'

  # Encor Solar Routes
  
  get 'encor_solar/locations'
  get 'encor_solar/arizona'
  get 'encor_solar/california_north'
  get 'encor_solar/california_south'
  get 'encor_solar/connecticut'
  get 'encor_solar/florida'
  get 'encor_solar/massachusetts'
  get 'encor_solar/nevada'
  get 'encor_solar/new_york_long_island'
  get 'encor_solar/new_york_nyc_boroughs'
  get 'encor_solar/rhode_island'
  get 'encor_solar/texas_austin_energy_oncor'
  get 'encor_solar/texas_san_antonio_cps'
  get 'encor_solar/utah'
end
