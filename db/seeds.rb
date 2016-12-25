User.create!(name: "Example User",
             email: "example@test.com",
             password: "nepal123",
             password_confirmation: "nepal123",
             admin: true)

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@test.com"
  password = "nepal123"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end