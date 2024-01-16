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

  describe 'Helper Methods' do
    user = User.create(name: 'John Doe', bio: 'student', photo: 'photo.jpg')

    it 'returns the 2 most recent posts' do
      # Assuming you have a way to create a user
      user = User.create(name: 'John Doe', bio: 'Some bio text', photo: 'profile.jpg')

      # Assuming you have a way to create posts
      Post.create(author_id: user.id, title: 'title', text: 'This is a post')
      Post.create(author_id: user.id, title: 'title', text: 'This is a post')
      Post.create(author_id: user.id, title: 'title', text: 'This is a post')
     

      expect(user.posts_counter).to eq(1)

    end
  end

  describe 'validations' do
    it 'ensures posts_counter is a non-negative integer' do
      user = User.new(name: "Name", posts_counter: 5)

      # Expect the user to be valid with a posts_counter of 5
      expect(user).to be_valid

      # Attempt to set a negative value for posts_counter
      user.posts_counter = -2
      expect(user).not_to be_valid

      # Attempt to set a non-integer value for posts_counter
      user.posts_counter = 3.5
      expect(user).not_to be_valid
    end

    describe '#recent_comments' do
      it 'returns the 3 most recent comments for the user' do
        user = User.create(name: 'John Doe', bio: 'Some bio text', photo: 'profile.jpg')
        post = Post.create(author_id: user.id, title: 'title', text: 'This is a post')  

        # Create some comments for the user
      
        comment1 = Comment.create(user_id: user.id, post_id: post.id, text: 'Comment 1', created_at: 3.days.ago)
        comment2 = Comment.create(user_id: user.id, post_id: post.id, text: 'Comment 2', created_at: 2.days.ago)
        comment3 = Comment.create(user_id: user.id, post_id: post.id, text: 'Comment 3', created_at: 1.day.ago)
        comment4 = Comment.create(user_id: user.id, post_id: post.id, text: 'Comment 4', created_at: Time.current)

        # Call the recent_comments method
        recent_comments = user.recent_comments

        # Expect the method to return the 3 most recent comments
        expect(recent_comments).to eq([comment4, comment3, comment2])

      # Ensure the order is correct (most recent first)
      expect(recent_comments).to eq(user.comments.order(created_at: :desc).limit(3))
    end
  end
  end
end
