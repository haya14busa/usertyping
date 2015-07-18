json.array!(@texts) do |text|
  json.extract! text, :id, :title, :body, :description, :collection_id
  json.url text_url(text, format: :json)
end
