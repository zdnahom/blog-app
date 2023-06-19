require 'rails_helper'

RSpec.describe 'Post page', type: :system do
  let(:user) { User.create!(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.') }
  let!(:post) do
    Post.create!([{ author: user, title: 'First Post', text: 'My first post' },
      { author: user, title: 'Second Post', text: 'My Second post' },
      { author: user, title: 'Third Post', text: 'My Third post' }])
    end

  describe 'Post index' do
    it 'shows user profile picture' do
      visit user_posts_path(user)
      expect(page).to have_css('img[alt="profile pic"]')
    end
    it 'shows user name' do
        visit user_posts_path(user)
        expect(page).to have_content(user.name)
    end

    it 'shows posts count' do
        visit user_posts_path(user)
        expect(page).to have_content(user.posts_counter)
    end

    it 'shows a post title' do
        visit user_posts_path(user)
        expect(page).to have_content(post[0].title)
    end
    
    it 'shows some of a post body' do
      visit user_posts_path(user)
      expect(page).to have_content(post[0].text)
    end

    it 'shows the first comment on a post' do
      Comment.create!(author: user, post: post[0], text:'niceeee')
      visit user_posts_path(user)
      expect(page).to have_content(post[0].comments[0].text)
    end

    it 'shows how many comments a post has' do
      Comment.create!(author: user, post: post[0], text:'niceeee')
      Comment.create!(author: user, post: post[0], text:'amazing')
      visit user_posts_path(user)
      expect(page).to have_content(post[0].comments_counter)
    end
    it 'shows how many likes a post has' do
      Like.create!(author: user, post: post[0])
      visit user_posts_path(user)
      expect(page).to have_content(post[0].likes_counter)
    end
    it 'shows pagination section' do
      visit user_posts_path(user)
      expect(page).to have_content('Pagination')
    end
    it 'shows pagination section' do
      visit user_posts_path(user)
      click_on 'First Post'
      expect(page).to have_content('My first post')
    end

  end

  describe 'Post show page' do
    it 'shows the title of a post' do
      visit user_post_path(user,post[0])
      expect(page).to have_content(post[0].title)
    end

    it 'shows who wrote the post' do
      visit user_post_path(user,post[0])
      expect(page).to have_content(post[0].author.name)
    end

    it 'shows how many comments a post has' do
      Comment.create!(author: user, post: post[0], text: 'Very nice')
      visit user_post_path(user,post[0])
      expect(page).to have_content(post[0].comments_counter)
    end
    it 'shows how many likes a post has' do
      Like.create!(author: user, post: post[0])
      visit user_post_path(user,post[0])
      expect(page).to have_content(post[0].likes_counter)
    end

    it 'shows the post body' do
      visit user_post_path(user, post[0])
      expect(page).to have_content(post[0].text)
    end

    it 'shows the username of each commentor' do
      Comment.create!(author: user, post: post[0], text: 'Very nice')
      visit user_post_path(user, post[0])

      post[0].comments.each do |comment|
        expect(page).to have_content(comment.author.name)
      end
    end

    it 'shows the comment each commentor left' do
      Comment.create!(author: user, post: post[0], text: 'Very nice')
      Comment.create!(author: user, post: post[0], text: 'good')
      visit user_post_path(user, post[0])

      post[0].comments.each do |comment|
        expect(page).to have_content(comment.text)
      end
    end

  end
end
