class Like < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  belongs_to :post, foreign_key: 'post_id', counter_cache: :likes_counter
  after_save :update_post_likes_counter
  after_destroy :update_post_likes_counter

  private

  # def update_post_likes_counter
  #   post.increment(:likes_counter)
  # end

  def update_post_likes_counter
    # Check if the associated post exists
    return unless post.present?

    # Increment the likes_counter on the associated post
    post.update_column(:likes_counter, post.likes.count)
  end
end
