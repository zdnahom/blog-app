require 'rails_helper'

RSpec.describe 'User page', type: :system do
  let(:user) { User.create!(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.') }
  let!(:post) do
    Post.create!([{ author: user, title: 'First Post', text: 'My first post' },
      { author: user, title: 'Second Post', text: 'My Second post' },
      { author: user, title: 'Third Post', text: 'My Third post' }])
    end

  describe 'User index' do
    it 'shows all users' do
      visit users_path(user)
      expect(page).to have_content(user.name)
    end

    it 'shows users picture' do
      visit users_path(user)
      expect(page).to have_css('img[alt="profile pic"]')
    end

    it 'shows how many posts a user has written' do
      visit users_path(user)
      expect(page).to have_content(user.posts_counter)
    end

    it 'user clicks on user name and goes to user page' do
      visit users_path(user)
      click_on user.name
      expect(page).to have_content(user.bio)
    end
  end

  describe 'User show page' do
    it 'shows user profile picture' do
      visit user_path(user)
      expect(page).to have_css('img[alt="profile pic"]')
    end

    it 'shows user name' do
      visit user_path(user)
      expect(page).to have_content(user.name)
    end

    it 'shows posts count' do
      visit user_path(user)
      expect(page).to have_content(user.posts_counter)
    end

    it 'shows user bio' do
      visit user_path(user)
      expect(page).to have_content(user.bio)
    end

    it 'shows user recent posts' do
      visit user_path(user)
      expect(page).to have_content(user.posts_counter)

      user.recent_posts.each do |post|
        expect(page).to have_content(post.text)
      end
    end

    it 'shows button to see all user posts' do
      visit user_path(user)
      expect(page).to have_link('See all posts')
    end

    it 'user clicks on post name and goes to post page' do
      visit user_path(user)
      click_on "My first post"
      expect(page).to have_content('My first post')
    end

    it 'user clicks on see all posts button and goes to user posts page' do
      visit user_path(user)
      click_on 'See all posts'
      expect(page).to have_content(user.name)

      user.posts.each do |post|
        expect(page).to have_content(post.text)
      end

    end
  end
end
