json.array!(@collections) do |collection|
  json.extract! collection, :id, :title, :description, :user_id
  json.url collection_url(collection, format: :json)
end
