

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
    let(:user) { User.new(name: 'John Doe', bio: 'student', photo: 'photo.jpg', posts_counter: 2) }

    it 'returns the 3 most recent posts' do
      # Assuming you have a way to create a user
      user = User.create(name: 'John Doe', bio: 'Some bio text', photo: 'profile.jpg')

      # Assuming you have a way to create posts
      Post.create(author_id: user.id, title: 'title', text: 'This is a post')
      Post.create(author_id: user.id, title: 'title', text: 'This is a post')
      Post.create(author_id: user.id, title: 'title', text: 'This is a post')

      expect(user.recent_posts(3).count).to eq(3)
    end
  end
end
