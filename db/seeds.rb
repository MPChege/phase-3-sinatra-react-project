puts "🌱 Seeding data..."

puts "🌱 house categories..."
studio = Category.create(category: "studio")
two_bedroom = Category.create(category: "2 Bedroom")
three_bedroom = Category.create(category: "3 bedroom")
four_bedroom = Category.create(category: "4 bedroom")
five_bedroom = Category.create(category: "5 bedroom")

puts "🌱 locations..."
nairobi = Location.create(location: "nairobi")
mombasa = Location.create(location: "mombasa")
kakamega = Location.create(location: "kakamega")
kisumu = Location.create(location: "kisumu")

puts "🌱 sellers..."
mark = Seller.create(name: "mark")
paul = Seller.create(name: "paul")
chege = Seller.create(name: "chege")
mercy = Seller.create(name: "mercy")
andrew = Seller.create(name: "andrew")

puts "🌱 houses..."

houses = [
  "https://images.pexels.com/photos/3935333/pexels-photo-3935333.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
  "https://images.pexels.com/photos/3935320/pexels-photo-3935320.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
  "https://images.pexels.com/photos/3958961/pexels-photo-3958961.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load",
  "https://images.pexels.com/photos/1732414/pexels-photo-1732414.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load",
  "https://images.pexels.com/photos/4469133/pexels-photo-4469133.jpeg",
  "https://images.pexels.com/photos/5008399/pexels-photo-5008399.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load",
  "https://images.pexels.com/photos/5178060/pexels-photo-5178060.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load",
  "https://images.pexels.com/photos/8583869/pexels-photo-8583869.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load",
  "https://images.pexels.com/photos/3195644/pexels-photo-3195644.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load",
  "https://skywadplans.com/images/planImages/plan/3-1.jpg",
  "https://images.pexels.com/photos/4469137/pexels-photo-4469137.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load",
  "https://images.pexels.com/photos/5008394/pexels-photo-5008394.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load",
  "https://images.pexels.com/photos/6635619/pexels-photo-6635619.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load",
  "https://images.pexels.com/photos/8186510/pexels-photo-8186510.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load",
  "https://images.pexels.com/photos/5502228/pexels-photo-5502228.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load",
  "https://images.pexels.com/photos/4946621/pexels-photo-4946621.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load",
  "https://images.pexels.com/photos/2119714/pexels-photo-2119714.jpeg?auto=compress&cs=tinysrgb&w=600",
  "https://images.pexels.com/photos/3663530/pexels-photo-3663530.jpeg?auto=compress&cs=tinysrgb&w=600",
  "https://images.pexels.com/photos/2119714/pexels-photo-2119714.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load",
  "https://images.pexels.com/photos/3663530/pexels-photo-3663530.jpeg?auto=compress&cs=tinysrgb&w=600",
  "https://images.pexels.com/photos/2119714/pexels-photo-2119714.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load",
  "https://images.pexels.com/photos/9992775/pexels-photo-9992775.jpeg?auto=compress&cs=tinysrgb&w=600",
  "https://images.pexels.com/photos/5824518/pexels-photo-5824518.jpeg?auto=compress&cs=tinysrgb&w=600",
  "https://images.pexels.com/photos/6444266/pexels-photo-6444266.jpeg?auto=compress&cs=tinysrgb&w=600",
  "https://images.pexels.com/photos/6782427/pexels-photo-6782427.jpeg?auto=compress&cs=tinysrgb&w=600",
  "https://images.pexels.com/photos/7045994/pexels-photo-7045994.jpeg?auto=compress&cs=tinysrgb&w=600",
  "https://images.pexels.com/photos/6444971/pexels-photo-6444971.jpeg?auto=compress&cs=tinysrgb&w=600"
]

houses.length.times do |i|
  House.create(
    location_id: [nairobi, mombasa, kakamega, kisumu].sample.id,
    category_id: [studio, two_bedroom, three_bedroom, four_bedroom, five_bedroom].sample.id,
    seller_id: [andrew, mercy, vincent, rajab, zablon].sample.id,
    price: rand(10000..150000).to_f,
    description: Faker::Lorem.paragraph(sentence_count: rand(2..5)),
    size_in_sqft: rand(500..10000),
    image: houses[i]
    # image: "https://via.placeholder.com/#{rand(500..1000)}x#{rand(200..700)}"
  )
end



puts "🌱 Done seeding!"
