# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Creating categories..."
# attach picture n each category
categories=Category.create!([
  { name: "Machine Accessories" },
  { name: "PCB Custom Boards" },
  { name: "License Keys" },
  { name: "DIY Kits" },
  { name: "Ready-made Machines" }
])

categories[0].category_avatar.attach(io: File.open(Rails.root.join('db/images/machine-accessories.png')), filename: 'prod01.png')
categories[1].category_avatar.attach(io: File.open(Rails.root.join('db/images/pcb.png')), filename: 'prod01.png')
categories[2].category_avatar.attach(io: File.open(Rails.root.join('db/images/keys.png')), filename: 'prod01.png')
categories[3].category_avatar.attach(io: File.open(Rails.root.join('db/images/diy1.png')), filename: 'prod01.png')
categories[4].category_avatar.attach(io: File.open(Rails.root.join('db/images/vendo-machines.png')), filename: 'prod01.png')

puts "Categories created."


puts "Creating 20 products..."
20.times do
  product=Product.create! name: Faker::Game.unique.title, description: Faker::Quote.unique.famous_last_words, price: Faker::Number.number(digits: 4), category_id: Faker::Number.between(from: 1, to: 5), classification: "AdopiSoft"
  product.product_image.attach(io: File.open(Rails.root.join('db/images/prod01.png')), filename: 'prod01.png')
  product.product_variants.attach(io: File.open(Rails.root.join('db/images/prod01.png')), filename: 'prod01.png')
  product.product_variants.attach(io: File.open(Rails.root.join('db/images/prod01.png')), filename: 'prod01.png')
  product.product_variants.attach(io: File.open(Rails.root.join('db/images/prod01.png')), filename: 'prod01.png')
end
puts "Products created."

puts "Rating each product..."

puts "Rating completed"
puts "Seedzing complerte. "
