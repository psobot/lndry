class AddLengthToResource < ActiveRecord::Migration
  def change
    add_column :resources, :duration, :integer, :after => :description
  end
end
