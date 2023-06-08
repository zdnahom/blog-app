class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :likes
  has_many :comments

  validates :title, presence: true, length:  {in: 1..250}
  validates :comments_counter, :likes_counter, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  
  def update_posts_counter
    posts_counter = author.posts_counter || 0
    author.update(posts_counter: posts_counter + 1)
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
