class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :username, limit: 15
      t.text :post_content
      t.timestamps
    end
  end
end
