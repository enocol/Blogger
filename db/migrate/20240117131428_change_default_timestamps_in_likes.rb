class ChangeDefaultTimestampsInLikes < ActiveRecord::Migration[7.1]
  def up
    change_column_default :likes, :created_at, -> { 'CURRENT_TIMESTAMP' }
    change_column_default :likes, :updated_at, -> { 'CURRENT_TIMESTAMP' }
  end
end
