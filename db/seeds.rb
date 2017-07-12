User.create! name: "Phuc", email: "phuc@gmail.com", password: "123456",
  password_confirmation: "123456", admin: true, activated: true,
  activated_at: Time.zone.now

9.times do |n|
  name = Faker::Name.name
  email = "#{n+1}@gmail.com"
  password = "123456"
  User.create! name: name, email: email, password: password,
    password_confirmation: password, activated: true,
    activated_at: Time.zone.now
end

users = User.order :created_at
9.times do
  content = Faker::Lorem.sentence 5
  title = Faker::Lorem.sentence 3
  users.each{|user| user.microposts.create! content: content, title: title}
end

users = User.all
user  = users.first
following = users[2..8]
followers = users[3..7]
following.each{|followed| user.follow followed}
followers.each{|follower| follower.follow user}
