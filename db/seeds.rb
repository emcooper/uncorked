def create_users
  users = [
    ["Doug", "Miller", "dmiller", "doug@dmail.com", "I like big trucks and I like fine wine", "303-111-2222", "trucks4lyfe"]
    ]
  users.each do |user|
    User.create!(first_name: user[0],
                 last_name: user[1],
                 username: user[2],
                 email: user[3],
                 bio: user[4],
                 phone_number: user[5],
                 password: user[6])
    puts "User #{user.first_name} #{user.last_name} created"
  end
end

def create_fake_users
  500.times do
    user = User.new
    user.first_name = Faker::Name.first_name
    user.last_name = Faker::Name.last_name
    user.username = Faker::Internet.user_name("#{user.first_name} #{user.last_name}", %w(. _ -))
    user.email = Faker::Internet.email
    user.bio = Faker::Witcher.quote
    user.phone_number = Faker::PhoneNumber.phone_number
    user.password = Faker::Internet.password
    user.save
    puts "User #{user.first_name} #{user.last_name} created"
  end
end

def create_managers
  users = [
    ["Dave", "Miller", "davemiller", "dave@davemail.com", "I like fine wine", "303-111-2222", "wine4lyfe"]
    ]
  users.each do |user|
    User.create!(first_name: user[0],
                 last_name: user[1],
                 username: user[2],
                 email: user[3],
                 bio: user[4],
                 phone_number: user[5],
                 password: user[6],
                 role: 1)
    puts "Manager #{user.first_name} #{user.last_name} created"
  end
end

def create_fake_managers
  50.times do
    user = User.new
    user.first_name = Faker::Name.first_name
    user.last_name = Faker::Name.last_name
    user.username = Faker::Internet.user_name("#{user.first_name} #{user.last_name}", %w(. _ -))
    user.email = Faker::Internet.email
    user.bio = Faker::Witcher.quote
    user.phone_number = Faker::PhoneNumber.phone_number
    user.password = Faker::Internet.password
    user.role = 1
    user.save
    puts "Manager #{user.first_name} #{user.last_name} created"
  end
end

def create_admin
  User.create(first_name: 'Admin', last_name: 'Of The Site', email: 'admin@admin.com', password: 'password', role: 2)
  puts "Created admin user"
end

def create_venues
  venues = [
    ["Daves Bistro", "1200 David Street", "Davetown", "Davidson", "80001", "20.12", "122.40"]
    ]
  venues.each do |venue|
    Venue.create!(name: venue[0],
                 street_address: venue[1],
                 city: venue[2],
                 state: venue[3],
                 zip: venue[4],
                 lat: venue[5],
                 long: venue[6])
    puts "Venue #{venue.name} created"
  end
end

def create_fake_venues
  25.times do
    venue = Venue.new
    venue.name = Faker::Company.name
    venue.street_address = Faker::Address.street_address
    venue.state = Faker::Address.state
    venue.zip = Faker::Address.zip
    venue.lat = Faker::Address.latitude
    venue.long = Faker::Address.longitude
    venue.save
    puts "Venue #{venue.name} created"
  end
end

def create_wines
  wines = [
    ["Fallows Red", "A dark wine with strong flavours", 98, "Pinot Noir", "1651", "Fallows Yard"]
    ]
  wines.each do |wine|
    Wine.create!(name: wine[0],
                 description: wine[1],
                 rating: wine[2],
                 varietal: wine[3],
                 vintage: wine[4],
                 vineyard: wine[5])
    puts "Wine #{wine.name} created"
  end
end

def create_fake_wines
  500.times do
    wine = Wine.new
    wine.name = Faker::GameOfThrones.character + %w(Red White Rose Champagne Wine)
    wine.description = Faker::Witcher.quote
    wine.rating = Faker::PhoneNumber.subscriber_number(2)
    wine.varietal = Faker::GameOfThrones.house
    wine.vintage = Faker::PhoneNumber.subscriber_number(4)
    wine.vineyard = Faker::GameOfThrones.city
    wine.save
    puts "Wine #{wine.name} created"
  end
end
