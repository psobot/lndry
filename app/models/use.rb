class Use < ActiveRecord::Base

  belongs_to :resource
  belongs_to :user

  after_create :create_message

  def self.current
    where("? BETWEEN start and finish", Time.now.utc)
  end

  def create_message
    Message.create! :user => self.user, :when => self.finish
  end

end
