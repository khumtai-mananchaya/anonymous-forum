json.extract! post, :id, :user_id, :post_content, :no_of_likes, :no_of_dislikes, :post_created, :post_updated, :created_at, :updated_at
json.url post_url(post, format: :json)
