User.destroy_all
Product.destroy_all

USERS_COUNT = 10

random_users = HTTParty.get("https://randomuser.me/api/?results=#{USERS_COUNT}")

random_users['results'].each_with_index do |random_user, index|

  u = User.create!( email: "test#{index}@test.com",
                    password: '123123',
                    name: "#{random_user['name']['first'].capitalize} #{random_user['name']['last'].capitalize}",
                    avatar_url: random_user['picture']['medium'] )

  puts "create user #{u.name}"
end

# Create some products



Product.create!(user: User.all.sample, name: 'Tesla Model 3', picture_url: 'https://www.tesla.com/content/dam/tesla-site/sx-redesign/img/model3-proto/specs/compare-model3--left.png', initial_price: 60_000)

Product.create!(user: User.all.sample, name: 'Lexus ES 350', picture_url: 'https://www.cstatic-images.com/car-pictures/xl/usc60lec161a021001.png', initial_price: 35_000)

Product.create!(user: User.all.sample, name: 'Mercedes-Benz C-Class', picture_url: 'https://cars.usnews.com/static/images/Auto/izmo/i100899632/2019_mercedes_c_class_angularfront.jpg', initial_price: 65_000)

puts "products created!"

# Generate some Bids

Product.all.each do |product|
  3.times do
    Bid.create!(product: product, user: User.where.not(id: product.user.id).sample, value: [100, 500, 1000].sample)
  end
end

puts "Bids created!"