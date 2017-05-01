Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'homepage#homepage'

  get 'publicanalysis' => 'homepage#publicanalysis'

  get 'profile' => 'profile#profile'
  get 'profile/2' => 'profile#profile2'

  get 'analysis' => 'analysis#analysis'

  get 'save' => 'save#save'
  get '/save/topup'
  get '/save/withdraw'
  get '/save/history'

  get 'rewards' => 'rewards#rewards'
  get 'rewards/:id' => 'rewards#rewards_id'

  get 'users/sign_up'=> 'users#new'
  get 'users/sign_in' => 'users#sign_in'
  delete 'logout' => 'users#sign_out'

end
