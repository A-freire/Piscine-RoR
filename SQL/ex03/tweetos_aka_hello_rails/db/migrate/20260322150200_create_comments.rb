class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :cuicui_id
      t.integer :user_id

      t.timestamps
    end

    add_index :comments, :content
    add_index :comments, :cuicui_id
    add_index :comments, :user_id
  end
end
