require 'rails_helper'

RSpec.describe 'User page', type: :system do
  let(:user) { User.create!(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.', post_counter: 0) }
  let!(:post) do
    Post.create!(author: user, title: 'Hello', text: 'This is a post', comments_counter: 0, likes_counter: 0)
  end

  describe 'User index' do
    it 'shows all users' do
      visit users_path(user)
      expect(page).to have_content(user.name)
    end

    it 'shows users picture' do
      visit users_path(user)
      expect(page).to have_css('img[alt="user photo"]')
    end

    it 'shows users post_counter' do
      visit users_path(user)
      expect(page).to have_content(1)
    end

    it 'user clicks on user name and goes to user page' do
      visit users_path(user)
      click_on user.name
      expect(page).to have_content(user.name)
    end
  end
end
