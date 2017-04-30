Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'homepage#homepage'

  get '/profile' => 'profile#profile'
  get '/analysis' => 'analysis#analysis'
  get '/save' => 'save#save'
  get '/save/topup'
  get '/save/withdraw'
  get '/save/history' 
  get '/rewards' => 'rewards#rewards'
end
