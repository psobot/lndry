class AddRawEmailToUse < ActiveRecord::Migration
  def change
    add_column :uses, :raw_email, :text, :after => :finish
  end
end
