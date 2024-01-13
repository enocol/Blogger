require 'rails_helper'

RSpec.describe 'Users Controller', type: :request do
  describe 'GET /index' do
    it "Redirects to the users' list page" do
      get '/users/1/posts'
      expect(response).to render_template(:index)
      expect(response.body).to include('<title>BlogApp</title>')
    end

    it 'GET /users/id should succeed' do
      get '/users/1'
      expect(response.status).to eq(200)
    end
  end
end
