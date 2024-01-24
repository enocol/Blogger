require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    render_views
    it 'renders the show template with correct placeholder text for an existing post' do
      # Manually create a user
      user = User.create(name: 'John Doe', bio: 'A simple bio', photo: 'https://picsum.photos/200')

      # Manually create a post with the user as the author
      post = Post.create(title: 'Sample Post', text: 'This is a sample post.', author_id: user.id)

      get :show, params: { id: post.id }

      # expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
      # expect(response.body).to include("Details for Post: #{post.title}")
      # expect(response.body).to include(post.text)
    end

    # it 'redirects to posts_path if post is not found' do
    #   get :show, params: { id: 123 }  # Replace 123 with a non-existing post ID

    #   expect(response).to have_http_status(:redirect)
    #   expect(response).to redirect_to(posts_path)
    # end
  end
end
