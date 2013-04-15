class ChargesController < ApplicationController

def create
  # Amount in cents
  @amount = params[:amount]

  customer = Stripe::Customer.create(
    email: current_user.email,
    card:  params[:stripeToken]
  )

  charge = Stripe::Charge.create(
    customer:     customer.id,
    amount:       @amount,
    description:  'Storyboard customer',
    currency:     'usd'
  )

rescue Stripe::CardError => e
  flash[:error] = e.message
  redirect_to charges_path
end
  
  
end
