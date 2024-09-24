# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


product1=Product.create(
  name: "esp32",
  price: 999.00,
  description: "this is esp32"
)
product1.product_image.attach(io: File.open(Rails.root.join("db/images/header.jpg")), filename: "header.jpg")
product1.product_variants.attach([
  {
    io: File.open(Rails.root.join("db/images/1.jpg")), filename: "1.jpg"
  },
  {
    io: File.open(Rails.root.join("db/images/3.jpg")), filename: "3.jpg"
  },
  {
    io: File.open(Rails.root.join("db/images/6.jpg")), filename: "6.jpg"
  }
])
product2=Product.create(
  name: "esp32",
  price: 999.00,
  description: "this is esp32"
)

product2.product_image.attach(io: File.open(Rails.root.join("db/images/header1.jpg")), filename: "header.jpg")
product2.product_variants.attach([
  {
    io: File.open(Rails.root.join("db/images/2.jpg")), filename: "2.jpg"
  },
  {
    io: File.open(Rails.root.join("db/images/4.jpg")), filename: "4.jpg"
  },
  {
    io: File.open(Rails.root.join("db/images/5.jpg")), filename: "5.jpg"
  }
])

puts "Seedzing complerte. "
