class ResourcesController < ApplicationController

  protect_from_forgery :except => :receive

  def index
    respond_to do |format|
      format.html do
        render
      end
      format.json do
        render :json => Resource.all.collect{|resource|{
          :id => resource.id,
          :name => resource.name,
          :busy => resource.is_in_use?,
          :free_at => resource.will_be_available
        }}
      end
    end
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
    respond_to do |format|
      format.html do
        if params[:key] != INCOMING_EMAIL_KEY
          render :json => {:status => 1, :message => "Authentication key doesn't match!"}
          return
        end

        message = parse_incoming params[:raw]

        find_or_create_user message[:email]

        unless @user.name
          @user.name = message[:name]
          @user.save!
        end

        @resource = Resource.find_by_email(message[:to])
        if @resource.is_in_use?
          existing = Use.current.where('resource_id = ?', @resource.id).first
          existing.finish = Time.now.utc
          existing.save!    
        end

        use = Use.create!(
          :user => @user,
          :resource => @resource,
          :start => Time.now.utc,
          :finish => (Time.now.utc + @resource.duration),
          :raw_email => params[:raw]
        )
        use.create_message

        render :json => {:status => 0}
      end
      format.json do
        begin
          raise "No API key found!" if not params[:key]
          auth_user = User.find_by_key params[:key]

          raise "API key invalid!" if not auth_user
          
          raise "Email required!" if not params[:email] #TODO: move to model validation
          find_or_create_user params[:email]

          unless @user.name
            @user.name = params[:name]
            @user.save!
          end

          @resource = Resource.find(params[:id])
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
            :raw_email => "API Call from user ##{auth_user.id}: #{params.to_s}" #TODO: holy fuck this is a quick hack
          )
          use.create_message if params[:send_email]

          render :json => {:status => 0, :message => "success"}
        rescue Exception => exc
          render :json => {:status => 1, :message => exc.message}
        end
      end
    end
  end

protected

  def find_or_create_user email
    @user = User.find_by_email(email)
    if not @user
      @user = User.create! :email => email
    end
    @user
  end

  def parse_incoming string
    message = Mail.read_from_string(string)

    from_name = message[:from].to_s.split('<')[0].strip rescue nil
    email = message[:from].addresses[0].to_s rescue nil

    {
      :name => from_name,
      :email => email,
      :to => message[:delivered_to].to_s
    }
  end

end
