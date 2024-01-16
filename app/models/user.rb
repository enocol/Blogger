class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_many :posts, foreign_key: 'author_id', counter_cache: true
  has_many :comments, dependent: :destroy
  has_many :like, dependent: :destroy
  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_create :update_posts_counter

  def recent_posts(limit = 3)
    posts.order(created_at: :desc).limit(limit)
  end

  def recent_comments
    comments.order(created_at: :desc).limit(3)
  end

  def recent_likes
    likes.order(created_at: :desc).limit(3)
  end

  def likes?(post)
    likes.exists?(post_id: post.id)
  end

  def update_posts_counter
    # post.increment!(:posts_counter)
    increment!(:posts_counter)
  end

  enum role: { admin: 0, user: 1 }
end
