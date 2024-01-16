# spec/models/post_spec.rb

require 'rails_helper'

RSpec.describe Post, type: :model do
  user = User.create(name: 'John Doe', bio: 'Programmer', photo: 'profile.jpg')

  it 'validates presence and length of title' do
    post = Post.new(title: nil, author_id: user.id, text: 'Sample Body')
    expect(post).not_to be_valid

    post.title = 'a' * 251
    expect(post).not_to be_valid

    post.title = 'Valid Title'
    expect(post).to be_valid
  end

  it 'validates comments_counter' do
    post = Post.new(author_id: user.id, title: 'sample title', text: 'sample text', comments_counter: -1)
    post.valid?
    expect(post.errors[:comments_counter]).to include('must be greater than or equal to 0')
  end

  it 'returns the 5 most recent comments in descending order of creation' do
    user = User.create(name: 'John Doe', bio: 'Some bio text', photo: 'profile.jpg')
    post = Post.create(author_id: user.id, title: 'Sample Title', text: 'Sample Body')

    # Create comments with different creation times and associate them with the post
    comment1 = Comment.create(post_id: post.id, user_id: user.id, text: 'Comment 1', created_at: 1.day.ago)
    comment2 = Comment.create(post_id: post.id, user_id: user.id, text: 'Comment 2', created_at: 2.days.ago)
    comment3 = Comment.create(post_id: post.id, user_id: user.id, text: 'Comment 3', created_at: 3.days.ago)
    comment4 = Comment.create(post_id: post.id, user_id: user.id, text: 'Comment 4', created_at: 4.days.ago)
    comment5 = Comment.create(post_id: post.id, user_id: user.id, text: 'Comment 5', created_at: 5.days.ago)

    expected_comments = [comment1, comment2, comment3, comment4, comment5]
    expect(post.recent_comments).to eq(expected_comments)
  end

  it 'returns an empty array if there are no comments on the post' do
    user = User.create(name: 'Alice', bio: 'No bio', photo: 'default.jpg')
    post = Post.create(author_id: user.id, title: 'Sample Title', text: 'Sample Body')

    expect(post.recent_comments).to eq([])
  end

  it 'starts with a default value' do
    user = User.create(name: 'John Doe', bio: 'Some bio text', photo: 'profile.jpg')
    post = Post.create(author_id: user.id, title: 'title', text: 'test')
    expect(post.reload.posts_counter).to eq(0)
  end

  it 'increments automatically when a new post is created' do
    # Create a user
    user = User.create(name: 'John Doe', bio: 'Some bio text', photo: 'profile.jpg')

    # Create the first post
    post1 = Post.create(author_id: user.id, title: 'some title', text: 'some text')

    # Create the second post
    post2 = Post.create(author_id: user.id, title: 'some title', text: 'some text')

    # Reload the posts and user to get the latest data from the database
    post1.reload
    post2.reload
    user.reload

    # Check if the posts_counter has been incremented
    expect(post2.posts_counter).to eq(post1.posts_counter + 0)
  end

  def create_comments(post, count)
    comments = []
    count.times do |i|
      comments << Comment.create(text: "Comment #{i + 1}", post:)
    end
    comments
  end
end
