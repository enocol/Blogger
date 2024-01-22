class AddForeignKeyToYourTable < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :comments, :users, column: :user_id
    add_foreign_key :comments, :posts, column: :post_id
  end
end
