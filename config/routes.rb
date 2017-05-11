Rails.application.routes.draw do
  devise_for :users,
  controllers: {
    :sessions => 'users/sessions',
    :registrations =>'users/registrations'
  },
  path: '/',
  path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    sign_up: 'signup',
    edit: 'editprofile',
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'homepage#homepage'
  get 'publicanalysis' => 'homepage#publicanalysis'

  resources :profiles
  get 'profileaccount' => 'profiles#bankaccount'
  put 'profileaccount' => 'profiles#updatebankdetails'

  resources :analysis


  get 'transactions' => 'transactions#index'
  get 'transactions/new' => 'transactions#new'
  post 'transactions/new' => 'transactions#create'
  post 'transactions/newstripe' => 'transactions#createstripe'
  get 'transactions/withdraw' => 'transactions#withdrawnew'
  put 'transactions/withdraw' => 'transactions#withdrawcreate'

  get 'rewards' => 'rewards#rewards'

  get 'rewards/rewardslist' => 'rewards#rewardslist'
  get 'rewards/:id' => 'rewards#rewards_id', :as => 'reward'


  post 'rewards/:id' => 'rewards#claimed' , as:"claimed"


end
