

require 'rails_helper'

RSpec.describe Like, type: :model do
  describe '#update_post_likes_counter' do
    let(:user) { User.create(name: 'John Doe', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'teacher') }
    let(:post) { Post.create(title: 'Test Post', text: 'This is a test post', author_id: user.id) }

    it 'increments post likes counter after creating a like' do
      expect { Like.create(user_id: user.id, post_id: post.id) }.to change { post.reload.likes_counter }.by(1)
    end

    it 'decrements post likes counter after destroying a like' do
      like = Like.create(user_id: user.id, post_id: post.id)
      expect { like.destroy }.to change { post.reload.likes_counter }.by(-1)
    end

    it 'does not change post likes counter on save without creating a new like' do
      expect { post.save }.not_to(change { post.reload.likes_counter })
    end

    it 'does not change post likes counter on update without creating a new like' do
      post.save
      post.update(title: 'Updated Title')
      expect(post.reload.likes_counter).to eq(0)
    end
  end
end
