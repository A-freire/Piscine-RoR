class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.integer :cuicui_id

      t.timestamps
    end

    add_index :likes, :user_id
    add_index :likes, :cuicui_id
  end
end
