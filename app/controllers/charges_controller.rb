class ChargesController < ApplicationController
  before_filter :signed_in_user
  
  def create
    # Amount in cents
    @amount = params[:amount]
    @user = current_user
    @balance = @user.storyboard_points
  
    customer = Stripe::Customer.create(
      email: @user.email,
      card:  params[:stripeToken]
    )
  
    charge = Stripe::Charge.create(
      customer:     customer.id,
      amount:       @amount,
      description:  'Storyboard customer',
      currency:     'usd'
    )
    
    @user.update_storyboard_points!(@user, @balance + @amount.to_i)
    flash[:success] = "Please sign in again to access your updated balance"
    redirect_to new_session_url
  
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end
  
  
end
