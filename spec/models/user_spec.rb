require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'validates presence of name' do
      user = User.new(name: nil, bio: 'I am a user', photo: 'https://i.pravatar.cc/300')
      expect(user.valid?).to be(false)
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'validates that posts_counter is an integer greater than or equal to zero' do
      user = User.new(name: 'John Doe', bio: 'student', photo: 'photo.jpg', posts_counter: 2)
      expect(user.valid?).to be_truthy

      user.posts_counter = -1
      expect(user.valid?).to be_falsey
      expect(user.errors[:posts_counter]).to include('must be greater than or equal to 0')
    end
  end

  describe '#recent_posts' do
    it 'returns recent posts in descending order' do
      user = User.create(name: 'John Doe', bio: 'Programmer', photo: "photo.jpg")
      older_post = Post.create(author_id: user.id, created_at: 4.days.ago,
      title: 'Older Post', text: 'This is a post'
      )
      recent_post1 = Post.create(author_id: user.id, created_at: 2.days.ago,
      title: 'Recent Post 1', text: 'This is a post'
      )
      recent_post2 = Post.create(author_id: user.id, created_at: 1.day.ago,
      title: 'Recent Post 2', text: 'This is a post'
      )

      result = user.recent_posts
      expect(result).to eq([recent_post2, recent_post1, older_post])
    end

    it 'limits the number of posts based on the provided limit' do
      user = User.create(name: 'John Doe', bio: 'Programmer', photo: 'photo.jpg')
      Post.create(author_id: user.id, title: 'Post 1', text: 'This is a post')
      Post.create(author_id: user.id, title: 'Post 2', text: 'This is a post')
      Post.create(author_id: user.id, title: 'Post 3', text: 'This is a post')

      result = user.recent_posts(2)
      expect(result.length).to eq(2)
    end
  end

  describe 'validations' do
    it 'ensures posts_counter is a non-negative integer' do
      user = User.new(name: 'Name', bio: 'programmer', posts_counter: 5)

      expect(user).to be_valid

      user.posts_counter = -2
      expect(user).not_to be_valid

      user.posts_counter = 3.5
      expect(user).not_to be_valid
    end
  end

  describe '#recent_comments' do
    it 'returns the 3 most recent comments for the user' do
      user = User.create(name: 'John Doe', bio: 'Some bio text', photo: 'profile.jpg')
      post = Post.create(author_id: user.id, title: 'title', text: 'This is a post')
      comment2 = Comment.create(user_id: user.id, post_id: post.id, text: 'Comment 2', created_at: 2.days.ago)
      comment3 = Comment.create(user_id: user.id, post_id: post.id, text: 'Comment 3', created_at: 1.day.ago)
      comment4 = Comment.create(user_id: user.id, post_id: post.id, text: 'Comment 4', created_at: Time.current)

      recent_comments = user.recent_comments
      expect(recent_comments).to eq([comment4, comment3, comment2])
      expect(recent_comments).to eq(user.comments.order(created_at: :desc).limit(3))
    end
  end
end
