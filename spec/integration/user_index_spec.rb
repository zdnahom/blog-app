require 'rails_helper'

RSpec.describe 'User index page', type: :system do
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

  describe 'User index' do
    it 'shows all users' do
      visit users_path
      users.each do |user|
        expect(page).to have_content(user.name)
      end
    end

    it 'shows users picture' do
      visit users_path
      expect(page).to have_css('img[alt="profile pic"]')
    end

    it 'shows how many posts a user has written' do
      visit users_path
      expect(page).to have_content(users[0].posts_counter)
    end

    it 'user clicks on user name and goes to user page' do
      visit users_path
      click_on users[1].name
      expect(page).to have_content(users[1].bio)
    end
  end
end
