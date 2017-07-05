User.create! name: "Phuc", email: "phuc@gmail.com", password: "123456",
  password_confirmation: "123456", admin: true

49.times do |n|
  name = Faker::Name.name
  email = "#{n+1}@gmail.com"
  password = "123456"
  User.create! name: name, email: email, password: password,
    password_confirmation: password
end
