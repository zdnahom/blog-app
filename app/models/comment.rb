class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  belongs_to :post

  def update_comments_counter
    comments_counter = post.comments_counter || 0
    post.update(comments_counter: comments_counter + 1)
  end
end
