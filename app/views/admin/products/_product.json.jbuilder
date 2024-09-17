json.extract! product, :id, :name, :description, :price, :created_by_id, :created_at, :updated_at
json.url product_url(product, format: :json)
