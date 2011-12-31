class AddUseIdToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :use_id, :integer, :after => :user_id
  end
end
