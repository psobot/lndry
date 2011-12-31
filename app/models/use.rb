include  ActionView::Helpers::DateHelper

class Use < ActiveRecord::Base

  belongs_to :resource
  belongs_to :user

  after_create :create_message

  def self.current
    where("? BETWEEN start and finish", Time.now.utc)
  end

  def create_message
    Message.create! :user => self.user, :when => self.finish, :use => self
  end

  def email_variables
    {
      :resource => resource.name.downcase,
      :duration => time_ago_in_words(start)
    }
  end

end
