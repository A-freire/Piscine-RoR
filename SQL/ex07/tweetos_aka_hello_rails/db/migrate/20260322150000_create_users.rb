class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :since
      t.boolean :admin
      t.string :country

      t.timestamps
    end

    add_index :users, :name
    add_index :users, :email
  end
end
