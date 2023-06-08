require 'rails_helper'

RSpec.describe User, type: :model do
    #tests go here
    subject{User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')}

    before{ subject.save }

    describe 'Validations' do
        it 'name should be present' do
            subject.name = ''
            expect(subject).to_not be_valid
        end

        it 'posts_counter should be an integer' do
            subject.posts_counter = 1.4
            expect(subject).to_not be_valid
        end

        it 'posts_counter should be greater than or equal to zero' do
            subject.posts_counter = -1
            expect(subject).to_not be_valid
        end
    end

    describe '#recent_posts' do
        it 'should return 3 recent posts' do
            first_post = Post.create(author: subject, title: 'Hello', text: 'This is my first post')
            second_post = Post.create(author: subject, title: 'Hello2', text: 'This is my 2nd post')
            third_post = Post.create(author: subject, title: 'Hello3', text: 'This is my 3rd post')
            forth_post = Post.create(author: subject, title: 'Hello4', text: 'This is my 4th post')
            fifth_post = Post.create(author: subject, title: 'Hello5', text: 'This is my 5th post')

            expect(subject.recent_posts.length).to eq 3
            expect(subject.recent_posts[0].title).to eq 'Hello5'
        end
    end
  end