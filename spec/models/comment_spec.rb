require 'rails_helper'

RSpec.describe Comment, type: :model do
    #tests go here
    user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.')
    post = Post.create(author: user, title: 'Hello', text: 'This is my first post')

    subject{Comment.create(post: post, author: user, text: 'Hi Tom!' )}

    before{ subject.save }

    describe '#update_comments_counter' do
        it 'should increment the comments_counter of a given post to 1' do
            subject.update_comments_counter

            expect(subject.post.comments_counter).to eq 1
        end
    end
  end