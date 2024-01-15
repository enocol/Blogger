

json.extract! user, :id, :title, :text, :comments_counter, :likes_counter, :author_id, :created_at, :updated_at
json.url user_url(user, format: :json)
