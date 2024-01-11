json.extract! post, :id, :title, :text, :CommentsCounter, :LikesCounter, :AuthorId, :created_at, :updated_at
json.url post_url(post, format: :json)
