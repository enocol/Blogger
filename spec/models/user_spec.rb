# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_numericality_of(:posts_counter).only_integer.is_greater_than_or_equal_to(0) }

  # Additional validation tests
  it { is_expected.to have_many(:posts).with_foreign_key('author_id') }
  it { is_expected.to have_many(:comments) }
  it { is_expected.to have_one(:like) }
end
