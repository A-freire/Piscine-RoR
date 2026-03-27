class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.references :user, null: false, foreign_key: true
      t.integer :last_editor_id
      t.datetime :last_edited_at

      t.timestamps
    end

    add_index :posts, :title, unique: true
    add_index :posts, :last_editor_id
    add_foreign_key :posts, :users, column: :last_editor_id
  end
end
