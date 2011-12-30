class ResourcesController < ApplicationController

  def index
    
  end

  def use
    
  end

  def letmeknow
    cookies[:email] = params[:email_form][:email]
    @user = User.find_by_email(params[:email_form][:email])
    if not @user
      @user = User.create! :email => params[:email_form][:email]
    end
    Message.create! :user_id => @user.id, :if => 'washer_available?'
    flash[:notice] = "You'll be notified when the next washer is available."
    redirect_to :root
  end

end
