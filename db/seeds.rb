# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Post.destroy_all

Faker::Name.unique.clear
Faker::Internet.unique.clear

10.times do |user|
  user = User.new
  user.email = Faker::Internet.unique.email
  user.password = "password"
  user.name = Faker::Name.unique.first_name
  user.description = Faker::Lorem.paragraph

  img = URI.open(Faker::Avatar.image)
  user.photo.attach(io: img, filename: img)

  user.save
end

User.all.each do |user|
  10.times do
    Post.create({
      title: Faker::Lorem.sentence,
      content: Faker::Lorem.paragraphs.join(" "),
      user_id: user.id
    })
  end
end
