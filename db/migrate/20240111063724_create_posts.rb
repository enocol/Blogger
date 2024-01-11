class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :text
      t.integer :comments_counter
      t.integer :likes_counter
      t.bigint :author_id

      t.timestamps
      t.index :author_id
      t.foreign_key :users, column: :author_id, primary_key: :id, on_delete: :cascade
    end
  end
end
