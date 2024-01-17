class Comment < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :post, class_name: 'Post'
  after_create :update_post_comment_counter

  private

  def update_post_comment_counter
    post.increment!(:comments_counter)
  end
end
