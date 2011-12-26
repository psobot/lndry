class ResourcesController < ApplicationController

  def index
    
  end

  def use
    
  end

  def letmeknow
    cookies[:email] = params[:email_form][:email]
    @user = User.find_by_email(params[:email_form][:email])
    if @user
      
    else
      User.create! :email => params[:email_form][:email]
    end
    redirect_to :root
  end

end
