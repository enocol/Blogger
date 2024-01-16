class Comment < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.references :post, foreign_key: { to_table: :posts }, null: false, default: 0
      t.references :user, foreign_key: { to_table: :users }, null: false, default: 0
      t.text :text

      t.timestamps
    end
  end
end
