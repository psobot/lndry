class Message < ActiveRecord::Base

  belongs_to :user

  def self.send_all
    logger.debug "Sending messages to everybody..."
    all.each do |message|
      logger.debug "Evaluating message for user ##{message.user_id}"
      if message.when and message.when < Time.now.utc
        UserMailer.done_reminder_for(message.user).deliver
      elsif message.if
        begin
          if Resource.send(message.if)
            response = UserMailer.available_reminder_for(message.user).deliver
            if response.status == "ok"
              message.destroy
            else
              logger.debug "Whoops, something went very wrong. #{response.message}"
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
