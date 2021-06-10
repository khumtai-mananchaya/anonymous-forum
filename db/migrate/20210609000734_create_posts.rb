class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :post_content
      t.integer :no_of_likes
      t.integer :no_of_dislikes
      t.datetime :post_created
      t.datetime :post_updated

      t.timestamps
    end
  end
end
