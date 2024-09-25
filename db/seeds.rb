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
product1.product_image.attach(io: File.open(Rails.root.join("db/images/cta1.png")), filename: "cta1.png")
product1.product_variants.attach([
  {
    io: File.open(Rails.root.join("db/images/cta1.png")), filename: "cta1.png"
  },
  {
    io: File.open(Rails.root.join("db/images/cta1.png")), filename: "cta1.png"
  },
  {
    io: File.open(Rails.root.join("db/images/cta1.png")), filename: "cta1.png"
  }
])
product2=Product.create(
  name: "esp32",
  price: 999.00,
  description: "this is esp32"
)

product2.product_image.attach(io: File.open(Rails.root.join("db/images/prod01.png")), filename: "prod01.png")
product2.product_variants.attach([
  {
    io: File.open(Rails.root.join("db/images/prod01.png")), filename: "prod01.png"
  },
  {
    io: File.open(Rails.root.join("db/images/prod01.png")), filename: "prod01.png"
  },
  {
    io: File.open(Rails.root.join("db/images/prod01.png")), filename: "prod01.png"
  }
])

puts "Seedzing complerte. "
