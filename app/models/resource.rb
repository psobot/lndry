class Resource < ActiveRecord::Base

  belongs_to :type
  has_many :uses

  Type.all.each do |type|
    # Returns the first available washer/dryer/whatever, or nil if there is none.
    define_singleton_method "#{type.slug}_available?" do
      where('type_id = ?', type.id).not_in_use.first
    end
  end

  def self.all_busy?
    !not_in_use.present?
  end

  def self.find_by_email email
    
    # Slug could be "washer", "washer1", "dryer2", etc...
    # If slug has no number on the end, assume "first available"
    # else, kick whatever was already used and add new use.

    matches = email.match /([a-z]+)([0-9])?@#{HOST}/i
    
    if not matches
      render :nothing
      return
    end

    _type = Type.find_by_slug matches[1]
    raise ActiveRecord::RecordNotFound if not _type

    _order = matches[2]

    if not _order
      r = self.not_in_use.where('type_id = ?', _type.id).first
      r = self.next_to_finish_of_type _type if not r
    else
      r = self.find_by_type_id_and_order _type.id, _order
    end

    logger.debug "Returning resource id #{r.id} for email #{email}"

    r
  end

  def self.next_to_finish_of_type _type
     joins(:uses).where('type_id = ? AND uses.finish > ?', _type.id, Time.now.utc).order('uses.finish ASC').first
  end

  def self.not_in_use
    where("NOT EXISTS (SELECT id FROM uses WHERE uses.resource_id = resources.id AND ? BETWEEN start and finish)", Time.now.utc)
  end

  def self.all_for_api
    all.collect{|resource|{
      :id => resource.id,
      :name => resource.name,
      :busy => resource.is_in_use?,
      :free_at => resource.will_be_available
    }}
  end

  def name
    return attributes['name'] if attributes['name']
    return (type.name + ' ' + order.to_s)
  end

  def email_variables
    {
      :resource_name => "#{type.name.downcase} #{order}"
    }
  end

  def email_address
    "#{type.slug}#{order}@#{HOST}"
  end
  
  def email_link
    "mailto:#{self.email_address}?subject=I'm doing Laundry!&body=I just put my laundry in #{type.name.downcase} #{order}."
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
