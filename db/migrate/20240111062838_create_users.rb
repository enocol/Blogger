# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :title
      t.text :text
      t.integer :comments_counter
      t.string :likes_counter
      t.bigint :author_id

      t.timestamps
      t.index :author_id
      t.foreign_key :users, column: :author_id, primary_key: :id, on_delete: :cascade
    end
  end
end
