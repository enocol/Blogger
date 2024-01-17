class Like < ApplicationRecord
  belongs_to :user, foreign_key: {to_table: :users}, class_name: 'User'
  belongs_to :post, foreign_key: {to_table: :posts}, class_name: 'Post'

  after_save :update_post_likes_counter
  after_destroy :update_post_likes_counter

  private

  def update_post_likes_counter
    return unless post.present?

    if saved_change_to_id? && saved_change_to_id[0].nil?
      # The record is being created
      post.increment(:likes_counter)
    elsif destroyed?
      # The record is being destroyed
      post.decrement(:likes_counter)
    end
  end
end
