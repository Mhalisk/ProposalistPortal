1.times do |user|
  User.create!(email: "admin@encorsolar.com", password: "asdfasdf", roles: "admin")
end

puts '1 admin user created'
