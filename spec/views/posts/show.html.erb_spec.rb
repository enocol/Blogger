require 'rails_helper'

RSpec.describe 'Post show page', type: :system do
  before(:each) do
    @user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    @post = Post.create(author: @user, title: 'Hello', text: 'This is my first post')

    @user2 = User.create(name: 'Alice', photo: 'https://unsplash.com/photos/xyz', bio: 'Alice\'s bio.')
    @comment1 = Comment.create(post: @post, user: @user2, text: 'Great post!')
  end

  after(:each) do
    Comment.destroy_all
    Post.destroy_all
    User.destroy_all
  end

  it "I can see the post's title." do
    visit user_post_path(@user, @post)
    puts page.text
    expect(page).to have_content 'Tom'
  end

  it 'I can see who wrote the post.' do
    visit user_post_path(@user, @post)
    expect(page).to have_content 'Tom'
  end

  it 'I can see how many comments it has.' do
    visit user_post_path(@user, @post)
    expect(page).to have_content 'Number of Comments: 1'
  end

  it 'I can see how many likes it has.' do
    visit user_post_path(@user, @post)
    expect(page).to have_content 'Number of Likes: 0' # Assuming there are no likes for simplicity
  end

  it 'I can see the post body.' do
    visit user_post_path(@user, @post)
    expect(page).to have_content 'This is my first post'
  end

  it 'I can see the username of each commentator.' do
    visit user_post_path(@user, @post)
    expect(page).to have_content 'Alice'
  end

  it 'I can see the comment each commentator left.' do
    visit user_post_path(@user, @post)
    expect(page).to have_content 'Great post!'
  end
end
