json.extract! article, :id, :title, :content, :image, :user_id, :reports_count, :archived, :created_at, :updated_at
json.url article_url(article, format: :json)
