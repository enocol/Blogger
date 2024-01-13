class AddColumnT0Users < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :role, :integer, default: 1
  end
end
