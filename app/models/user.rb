class User < ActiveRecord::Base

  has_many :uses
  has_many :messages

end
