class Resource < ActiveRecord::Base

  belongs_to :type
  has_many :uses

  Type.all.each do |type|
    define_singleton_method "#{type.slug}_available?" do
      joins(:uses).where("type_id = ? AND ? BETWEEN start and finish", type.id, Time.now.utc).count < Resource.where('type_id = ?', type.id).count
    end
  end

  def is_in_use?
    uses.where("? BETWEEN start and finish", Time.now.utc).present?
  end

  def is_available?
    !is_in_use?
  end

  def will_be_available
    u = uses.where("? BETWEEN start and finish", Time.now.utc).first
    if u
      u.finish
    else
      Time.now.utc
    end
  end

end
