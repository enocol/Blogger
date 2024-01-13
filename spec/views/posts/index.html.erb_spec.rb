require 'rails_helper'

RSpec.describe 'User post index page', type: :system do
  before(:each) do
    @user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    @post = Post.create(author: @user, title: 'Hello', text: 'This is my first post')

    6.times do |i|
      Comment.create(post: @post, user: @user, text: "Comment #{i}")
    end
  end

  after(:each) do
    Comment.destroy_all
    Post.destroy_all
    User.destroy_all
  end

  it 'I can see the user\'s username.' do
    visit user_posts_path(@user)
    expect(page).to have_content @user.name
  end

  it 'I can see the number of posts the user has written.' do
    visit user_posts_path(@user)
    expect(page).to have_content 'Number of Posts: 1'
  end

  it 'I can see some of the post\'s body.' do
    visit user_posts_path(@user)
    expect(page).to have_content 'This is my first post'
  end

  it 'I can see how many comments a post has.' do
    visit user_posts_path(@user)
    expect(page).to have_content(/Comments: 6/i, normalize_ws: true)
  end

  it 'I can see how many likes a post has.' do
    visit user_posts_path(@user)
    expect(page).to have_content(/Likes: 0/i)
  end

  it 'I can see a section for pagination if there are more posts than fit on the view.' do
    10.times do |i|
      Post.create(author: @user, title: "Post #{i + 1}", text: "This is post number #{i + 1}")
    end

    visit user_posts_path(@user)

    expect(page).to have_css('.pagination')
    expect(page).to have_link('2')
  end

  it 'I can see the user\'s profile picture.' do
    visit user_posts_path(@user)
    expect(page).to have_css("img[src='https://unsplash.com/photos/F_-0BxGuVvo']")
  end

  it 'I can see a post\'s title.' do
    visit user_posts_path(@user)
    expect(page).to have_link(href: user_post_path(@user, @post))
  end

  it 'I can see the first comment on a post.' do
    visit user_posts_path(@user)
    expect(page).to have_content(/Comments: \d+/)
  end

  it 'Redirects to the post\'s show page when I click on a post.' do
    visit user_posts_path(@user)
    click_link(href: user_post_path(@user, @post))
    expect(page).to have_current_path(user_post_path(@user, @post))
    expect(page).to have_content 'This is my first post'
  end
end
