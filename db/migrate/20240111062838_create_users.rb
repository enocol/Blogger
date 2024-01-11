# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :bio
      t.string :photo
      t.string :posts_counter

      t.timestamps
    end
  end
end
