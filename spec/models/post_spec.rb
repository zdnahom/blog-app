require 'rails_helper'

RSpec.describe Post, type: :model do
  # tests go here
  user1 = User.create(name: 'nahom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
  subject { Post.new(author: user1, title: 'Hello', text: 'This is my first post') }

  before { subject.save }

  describe 'Validations' do
    it 'title should be present' do
      subject.title = ''
      expect(subject).to_not be_valid
    end

    it 'title should have a maximum length of 250' do
      subject.title = 't' * 251
      expect(subject).to_not be_valid
    end

    it 'comments_counter should be an integer' do
      subject.comments_counter = 1.4
      expect(subject).to_not be_valid
    end

    it 'comments_counter should be greater than or equal to zero' do
      subject.comments_counter = -1
      expect(subject).to_not be_valid
    end

    it 'likes_counter should be an integer' do
      subject.likes_counter = 1.4
      expect(subject).to_not be_valid
    end

    it 'likes_counter should be greater than or equal to zero' do
      subject.likes_counter = -1
      expect(subject).to_not be_valid
    end
  end

  describe '#recent_comments' do
    it 'should return 5 recent comments' do
      user2 = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                          bio: 'Teacher from Poland.')
      user3 = User.create(name: 'Lala', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                          bio: 'Teacher from Kenya.')
      user4 = User.create(name: 'Lolo', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                          bio: 'Teacher from Nigeria.')
      user5 = User.create(name: 'Lele', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                          bio: 'Teacher from Ethiopia.')
      user6 = User.create(name: 'Lulu', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                          bio: 'Teacher from Uganda.')

      Comment.create(post: subject, author: user2, text: 'Hi Tom!')
      Comment.create(post: subject, author: user3, text: 'Hi Tom!')
      Comment.create(post: subject, author: user4, text: 'Hi Tom!')
      Comment.create(post: subject, author: user5, text: 'Hi Tom!')
      Comment.create(post: subject, author: user6, text: 'Hi Tom!')
      Comment.create(post: subject, author: user5, text: 'Hi Tom!')
      Comment.create(post: subject, author: user2, text: 'Hi Tom, well done!')

      expect(subject.recent_comments.length).to eq 5
      expect(subject.recent_comments[0].text).to eq 'Hi Tom, well done!'
    end
    describe '#update_posts_counter' do
      it 'should increment posts_counter to 1' do
        subject.update_posts_counter

        expect(subject.author.posts_counter).to eq 1
      end
    end
  end
end
