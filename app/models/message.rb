class Message < ActiveRecord::Base

  belongs_to :user
  belongs_to :use

  def self.send_all
    logger.debug "Resending failed requests..."
    PostageApp::FailedRequest.resend_all
    logger.debug "Evaluating and sending messages..."
    all.each do |message|
      logger.debug "Evaluating message for user ##{message.user_id}"
      if message.when and message.when < Time.now.utc
        response = UserMailer.done_reminder_for(message.user, message.use).deliver #TODO: get reference to use
        if response.status != "ok"
          logger.warning "Could not immediately send message: #{response.message}"
        end
        message.destroy
      elsif message.if
        begin
          valid = Resource.send(message.if)
          if valid
            response = UserMailer.available_reminder_for(message.user, valid).deliver  #TODO: get reference to resource
            if response.status != "ok"
              logger.warning "Could not immediately send message: #{response.message}"
            end
            message.destroy
          end
        rescue NoMethodError
          logger.debug "NoMethodError on Resource for method: \"#{message.if}\""
        end
      end
    end
  end

  def self.pending_for? email
    joins(:user).where("users.email = ?", email).present?
  end

end
