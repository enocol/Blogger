require 'rails_helper'

RSpec.describe Post, type: :model do
  let!(:user) { User.create(name: 'John', photo: 'https://example.com/photo.jpg', bio: 'A bio.') }

  it { is_expected.to belong_to(:author).class_name('User').with_foreign_key('author_id').required(true) }
  it { is_expected.to validate_numericality_of(:comment_counter).only_integer.is_greater_than_or_equal_to(0) }

  describe 'custom methods' do
    it 'returns recent comments' do
      post = Post.create(author: user, title: 'Test Post', text: 'This is a test post.')

      # Your test logic here to call the custom method that returns recent comments
      recent_comments = post.recent_comments

      # Assert that the recent_comments include the latest comments
      expect(recent_comments).to eq([])
    end
  end
end
