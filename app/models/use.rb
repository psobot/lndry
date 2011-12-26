class Use < ActiveRecord::Base

  belongs_to :resource
  belongs_to :user

  def self.current
    where("? BETWEEN start and finish", Time.now.utc)
  end

end
