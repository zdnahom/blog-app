class Post < ApplicationRecord
    belongs_to :author, class_name: 'User', foreign_key: :author_id
    has_many :likes
    has_many :comments

    def update_posts_counter
        posts_counter = author.posts_counter || 0
        author.update(posts_counter: posts_counter + 1)
    end
end