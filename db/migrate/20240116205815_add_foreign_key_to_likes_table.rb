class AddForeignKeyToLikesTable < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :likes, :users, column: :user_id
    add_foreign_key :likes, :posts, column: :post_id
  end
end
