class ChargesController < ApplicationController
  before_filter :signed_in_user
  
  def create
    # Amount in cents
    @amount = params[:amount].to_i
    @user = current_user
    @sp = @user.storyboard_points
    @cp = @user.community_points
    @bonus_cp = (@amount / 500 ) * 100
  
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
    
    @user.update_storyboard_points!(@user, @sp + @amount)
    @user.update_community_points!(@user, @cp + @bonus_cp)
    flash[:success] = "Success! You've been credited #{@amount} Storyboard Points. Please sign in again to access your updated balance."
    redirect_to new_session_url
  
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end
  
  
end
