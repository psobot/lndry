class Message < ActiveRecord::Base

  belongs_to :user

  def self.send_all
    logger.debug "Sending messages to everybody..."
    all.each do |message|
      logger.debug "Evaluating message for user ##{message.user_id}"
      if message.when and message.when < Time.now.utc
        UserMailer.send_reminder_to message.user
      elsif message.if
        begin
          if Resource.send(message.if)
            r = UserMailer.send_available_to(message.user) 
            if r  #TODO: Fix
              message.destroy
            end
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
