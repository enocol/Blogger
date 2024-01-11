# frozen_string_literal: true

class CreateLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :likes do |t|
      t.bigint :UserId
      t.bigint :PostId

      t.timestamps
      t.index :UserId
      t.index :PostId
      t.foreign_key :users, column: :UserId, primary_key: :id, on_delete: :cascade
      t.foreign_key :posts, column: :PostId, primary_key: :id, on_delete: :cascade
    end
  end
end
