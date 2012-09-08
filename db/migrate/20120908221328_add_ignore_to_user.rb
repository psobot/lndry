class AddIgnoreToUser < ActiveRecord::Migration
  def change
    add_column :users, :ignore, :boolean, :default => false
  end
end
