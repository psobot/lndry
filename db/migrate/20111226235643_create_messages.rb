class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.datetime :when
      t.string :if

      t.timestamps
    end
  end
end
