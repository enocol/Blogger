# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.string :text
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
