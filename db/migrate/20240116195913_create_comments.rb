class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.integer :user, foreign_key: { to_table: :users }, null: false
      t.integer :post, foreign_key: { to_table: :posts }, null: false
      t.text :text

      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, :post_id
  end
end
