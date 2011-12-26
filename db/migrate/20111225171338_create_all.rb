class CreateAll < ActiveRecord::Migration
  def change
    create_table :types do |t|
      t.string :name
      t.string :slug
      t.timestamps
    end
    create_table :resources do |t|
      t.integer :type_id
      t.integer :order
      t.string :name
      t.string :location
      t.text :description

      t.timestamps
    end
    create_table :users do |t|
      t.string :email
      t.string :twitter
      t.string :key

      t.timestamps
    end
    create_table :uses do |t|
      t.integer :user_id
      t.integer :resource_id
      t.datetime :start
      t.datetime :finish

      t.timestamps
    end
  end
end
