json.extract! listing, :id, :guests, :bedrooms, :bathrooms, :city, :country, :street, :apt_number, :description, :name, :user_id, :created_at, :updated_at
json.url listing_url(listing, format: :json)
