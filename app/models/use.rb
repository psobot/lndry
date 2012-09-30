include  ActionView::Helpers::DateHelper

class Use < ActiveRecord::Base

  belongs_to :resource
  belongs_to :user

  after_initialize :init

  def init
    if self.resource && self.resource.type
      self.start  ||= Time.now.utc
      self.finish ||= self.start + self.resource.duration
    end
  end

  def self.total_loads_of_laundry
    joins(:resource).where('resources.type_id = 1').count
  end

  def self.current
    where("? BETWEEN start and finish", Time.now.utc)
  end

  def create_message
    Message.create! :user => self.user, :when => self.finish, :use => self
  end

  def email_variables
    {
      :resource => resource.name.downcase,
      :duration => time_ago_in_words(start),
      :reply => ((resource.type.id == 1) ? "Just reply to this email if you'd like to claim the first available dryer, as well." : "")  #bit of a hack
    }
  end

end
