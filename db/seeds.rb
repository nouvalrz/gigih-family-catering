# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

FactoryBot.create_list(:menu_category, 20)
orders = FactoryBot.build_list(:order, 30)
orders.each do |order| 
  order.add_menus([{id: rand(2..10), quantity: rand(2..10)}, {id: rand(2..10), quantity: rand(2..10)}])
  order.save
end