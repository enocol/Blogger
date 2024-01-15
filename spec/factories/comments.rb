

# spec/factories/comments.rb
FactoryBot.define do
  factory :comment do
    text { 'This is a comment body.' }

    # Assuming association with User
    association :user, factory: :user

    # Assuming association with Post
    association :post, factory: :post
  end
end
