require 'rails_helper'

RSpec.describe Comment, type: :model do
  # Associations
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:post) }

  # Custom Method Tests
  describe '#update_post_comment_counter' do
    let(:user) { create(:user) }
    let(:post) { create(:post, author: user) }
    let(:comment) { build(:comment, user:, post:) }
  end
end
