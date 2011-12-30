class ResourcesController < ApplicationController

  protect_from_forgery :except => :receive

  def index
    
  end

  def use
    
  end

  def letmeknow
    cookies[:email] = params[:email_form][:email]
    find_or_create_user params[:email_form][:email]
    Message.create! :user_id => @user.id, :if => 'washer_available?'
    flash[:notice] = "You'll be notified when the next washer is available."
    redirect_to :root
  end

  def receive
    if params[:key] != INCOMING_EMAIL_KEY
      render :json => {:status => 1, :message => "Authentication key doesn't match!"}
      return
    end

    find_or_create_user params[:email]

    unless @user.name
      @user.name = params[:name]
      @user.save!
    end

    @resource = Resource.find_by_email(params[:to])
    if @resource.is_in_use?
      existing = Use.current.where('resource_id = ?', @resource.id).first
      existing.finish = Time.now.utc
      existing.save!    
    end

    Use.create!(
      :user => @user,
      :resource => @resource,
      :start => Time.now.utc,
      :finish => (Time.now.utc + @resource.duration),
      :raw_email => params[:raw]
    )

    render :json => {:status => 0}
  end

protected

  def find_or_create_user email
    @user = User.find_by_email(email)
    if not @user
      @user = User.create! :email => email
    end
    @user
  end

end
