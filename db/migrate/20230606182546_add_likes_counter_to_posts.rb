class AddLikesCounterToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :Likes_counter, :integer
  end
end
