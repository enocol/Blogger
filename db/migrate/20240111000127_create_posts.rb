class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :text
      t.string :CommentsCounter
      t.string :LikesCounter
      t.bigint :author_id

      t.timestamps
      t.index :author_id
      t.foreign_key :users, column: :author_id, primary_key: :id, on_delete: :cascade
    end
  end
end
