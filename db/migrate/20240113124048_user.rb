class User < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.text :bio
      t.string :photo
      t.string :posts_counter

      t.timestamps
    end
  end
end
