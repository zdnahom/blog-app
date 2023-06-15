require 'rails_helper'
RSpec.describe 'Posts', type: :request do
  let!(:user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
  let!(:valid_attributes) { { author: user, title: 'Hello', text: 'This is my first post' } }

  describe 'GET /index' do
    it 'returns a successful response' do
      get user_posts_url(user)
      expect(response).to be_successful
    end

    it 'renders a correct template' do
      get user_posts_url(user)
      expect(response).to render_template('index')
    end

    it 'includes a placeholder' do
      get user_posts_url(user)
      expect(response.body).to include('Number of posts: 100')
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      post = Post.create! valid_attributes
      get user_post_url(user, post)
      expect(response).to be_successful
    end

    it 'renders a correct template' do
      post = Post.create! valid_attributes
      get user_post_url(user, post)
      expect(response).to render_template('show')
    end

    it 'includes a placeholder' do
      post = Post.create! valid_attributes
      get user_post_url(user, post)
      expect(response.body).to include('Post #1 by username')
    end
  end
end
