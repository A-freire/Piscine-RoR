class CreateCuicuis < ActiveRecord::Migration[7.0]
  def change
    create_table :cuicuis do |t|
      t.text :content
      t.integer :user_id

      t.timestamps
    end

    add_index :cuicuis, :content
    add_index :cuicuis, :user_id
  end
end
