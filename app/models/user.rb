class User < ActiveRecord::Base

  has_many :uses
  has_many :messages

  def first_name
    pieces = name.split(' ')
    if pieces.length == 1
      pieces[0]
    else
      pieces[0...-1].join(' ')
    end
  rescue
    nil
  end

  def last_name
    pieces = name.split(' ')
    pieces[-1]
  rescue
    nil
  end

  def email_variables
    {
      :first_name => (first_name or "resident"),
      :last_name => last_name,
      :name => (name or "resident")
    }
  end

end
