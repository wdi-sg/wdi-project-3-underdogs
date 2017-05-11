Rails.configuration.stripe = {
  # :publishable_key => ENV['PUBLISHABLE_KEY'],
  :publishable_key => 'pk_test_GxlJ2zTuO010UwjSgBavcpXv',
  # :secret_key      => ENV['SECRET_KEY']
  :secret_key      => 'sk_test_dGzEZHohsETmndIWlD8PFAgD'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
