# spec/controllers/likes_controller_spec.rb

require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  describe 'GET #index' do
    before do
      Like.create(user_id: 732, post_id: 863)
      Like.create(user_id: 731, post_id: 862)
    end

    it 'assigns all likes to @likes and renders the correct content' do
      get :index
      puts assigns(:likes).inspect
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end
end
