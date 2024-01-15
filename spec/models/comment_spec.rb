

require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe '#update_post_comment_counter' do
    let(:user) { User.create(name: 'Uthman', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Programmer') }
    let(:post) { Post.create(title: 'My life', text: 'Once upon a time ...', author_id: user.id) }
    let(:comment) { Comment.create(text: 'Nice piece', user_id: user.id, post_id: post.id) }

    it 'increments post comments counter after comment creation' do
      expect { comment }.to change { post.reload.comments_counter }.by(1)
    end

    it 'does not increment post comments counter on update' do
      comment.update(text: 'Updated comment text')
      expect(post.reload.comments_counter).to eq(1)
    end

    it 'does not increment post comments counter on destroy' do
      post.reload
      expect { Comment.destroy(comment.id) }.to_not(change { post.comments_counter })
      post.reload
    end
  end
end
