class Post < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'author_id'
  has_many :comments, dependent: :destroy, counter_cache: true, foreign_key: 'post_id'
  # has_many :likes, foreign_key: 'post_id', dependent: :destroy, counter_cache: true
  has_many :likes, dependent: :destroy, counter_cache: true
  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
