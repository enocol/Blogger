# frozen_string_literal: true

class CreateLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :likes do |t|
      t.bigint :user_id
      t.bigint :post_id

      t.timestamps
      t.index :user_id
      t.index :post_id
      t.foreign_key :users, column: :user_id, primary_key: :id, on_delete: :cascade
      t.foreign_key :posts, column: :post_id, primary_key: :id, on_delete: :cascade
    end
  end
end