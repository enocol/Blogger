require 'rails_helper'

RSpec.describe 'User index page', type: :system do
  describe 'User show page' do
    before(:each) do
      @user = User.create!(name: 'Landry', photo: '#photo_landry', bio: 'My bio #landry !', posts_counter: 0)

      # creating the instance post
      10.times do |i|
        @post = Post.create(author: @user, title: "#{i}/ Post ", text: "This is my #{i} post")
      end

      visit user_path(@user.id)
    end

    after(:each) do
      User.destroy_all
    end

    it 'I can see the user"s profile picture' do
      expect(page.find("#user-#{@user.id}img")['src']).to have_content @user.photo
    end

    it 'I can see the user"s username.' do
      expect(page).to have_content @user.name
    end

    it 'I can see the number of posts the user has written.' do
      expect(page).to have_content(/Number of posts: 10/i)
    end

    it 'I can see the user"s bio' do
      expect(page).to have_content 'My bio #landry !'
    end

    it 'I can see the user\'s first 3 posts.' do
      expect(page).to have_content('This is my 0 post', wait: 10)
      expect(page).to have_content('This is my 1 post', wait: 10)
      expect(page).to have_content('This is my 2 post', wait: 10)
    end

    # checking through the users post and  index pages
    it 'When I click to see all posts, it redirects me to the user\'s post\'s index page.' do
      visit user_path(@user.id)
      find('a', text: /See All Posts/i).click

      expect(page).to have_selector('.pagination', wait: 5)
    end

    it 'I can see a button that lets me view all of a user\'s posts.' do
      expect(page).to have_link('See all posts', href: user_posts_path(@user), id: 'see-all-posts-link')
    end

    it 'Clicking on a user\'s post redirects to the post\'s show page.' do
      post = @user.posts.first
      within("#post-#{post.id}") do
        click_link('Post', exact_text: true)
      end
      expect(page).to have_current_path(user_post_path(@user, post))
      expect(page).to have_content(post.text)
    end
  end
end
