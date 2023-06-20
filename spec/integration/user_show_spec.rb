require 'rails_helper'

RSpec.describe 'User show page', type: :system do
  let!(:users) do
   User.create([{name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.'},
    {name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from England.'},
    {name: 'Nahom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Ethiopia.'}])
   end
  let!(:posts) do
    Post.create!([{ author: users[0], title: 'First Post', text: 'My first post' },
                  { author: users[1], title: 'Second Post', text: 'My Second post' },
                  { author: users[2], title: 'Third Post', text: 'My Third post' }])
  end
describe 'User show' do
    it 'shows user profile picture' do
      visit user_path(users[0])
      expect(page).to have_css('img[alt="profile pic"]')
    end

    it 'shows user name' do
      visit user_path(users[0])
      expect(page).to have_content(users[0].name)
    end

    it 'shows posts count' do
      visit user_path(users[1])
      expect(page).to have_content(users[1].posts_counter)
    end

    it 'shows user bio' do
      visit user_path(users[1])
      expect(page).to have_content(users[1].bio)
    end

    it 'shows user recent posts' do
      visit user_path(users[2])
      expect(page).to have_content(users[2].posts_counter)

      users[2].recent_posts.each do |post|
        expect(page).to have_content(post.text)
      end
    end

    it 'shows button to see all user posts' do
      visit user_path(users[2])
      expect(page).to have_link('See all posts')
    end

    it 'user clicks on post name and goes to post page' do
      visit user_path(users[0])
      click_on 'My first post'
      expect(page).to have_content('My first post')
    end

    it 'user clicks on see all posts button and goes to user posts page' do
      visit user_path(users[0])
      click_on 'See all posts'
      expect(page).to have_content(users[0].name)

      users[0].posts.each do |post|
        expect(page).to have_content(post.text)
      end
    end
  end
end