require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  
  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #index' do
  render_views
    it 'renders the index template with correct placeholder text' do
      get :index

      # Assuming "Placeholder Text" is present in your view
      expect(response.body).to include('Here is a list of users')
    end
  end

  describe 'GET #show' do
    render_views
    it 'redirects to users_path if user is not found' do
      get :show, params: { id: 123 }  # Replace 123 with a non-existing user ID

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(users_path)
    end

    it 'renders the show template with correct placeholder text for existing user' do
      
      user = User.create(name: 'John Doe', bio: 'A simple bio', photo: 'https://picsum.photos/200')

      get :show, params: { id: user.id }

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
      expect(response.body).to include("This is the user with specific id")
    end
  end
end
