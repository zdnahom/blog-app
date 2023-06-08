require 'rails_helper'

RSpec.describe Like, type: :model do
    #tests go here
    user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.')
    post = Post.create(author: user, title: 'Hello', text: 'This is my first post')

    subject{Like.create(post: post, author: user)}

    before{ subject.save }

    describe '#update_likes_counter' do
        it 'should increment the likes_counter of a given post to 1' do
            subject.update_likes_counter

            expect(subject.post.likes_counter).to eq 1
        end
    end
  end