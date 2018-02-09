# Companies

1.times do |company|
  Company.create!(company_name: "Encor Solar")
end

puts "Company Encor Solar was created"

1.times do |company|
  Company.create!(company_name: "Powerhome Solar")
end

puts "Company Powerhome Solar was created"

# Locations

locations_arr = ['Arizona', 
'California (North)', 
'California (South)', 
'Connecticut', 
'Florida', 
'Massachusetts', 
'Nevada', 
'New York (Long Island)', 
'New York (NYC | The Boroughs)', 
'Rhode Island', 
'Texas (Austin Energy | Oncor)', 
'Texas (San Antonio | CPS)', 
'Utah'
]

13.times do |location|
  Location.create!(location: locations_arr[location])
end

puts "13 locations have been created"

# Users

1.times do |user|
  User.create!(email: "admin@encorsolar.com", password: ENV["ADMIN_PASSWORD"], roles: "admin")
end

puts '1 admin user created'