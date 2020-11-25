require "faker"

Argument.destroy_all
User.destroy_all


emails = %w[nawel@email.com patrick@email.com nooshin@email.com tatiana@email.com JasonBigHands@email.com spud@email.com jadam@email.com brick@email.com trumane@email.com jst@email.com]

puts "Generating users..."
emails.each do |email|
  user = User.new(email: email, password: 123456 )
  user.nickname = user.email.match(/.+?(?=@)/).to_s
  user.save!
end

parent = Argument.create!(
  content: "Parent: the sun is hot",
  source: Faker::Internet.url,
  # votes: (0..1000).to_a.sample,
  user: User.all.sample
)
parent2 = Argument.create!(
  content: "Parent: ice is cold",
  source: Faker::Internet.url,
  # votes: (0..1000).to_a.sample,
  user: User.all.sample
)
child = Argument.create!(
  content: "Child with two parents: temperature is subjective",
  source: Faker::Internet.url,
  # votes: (0..1000).to_a.sample,
  user: User.all.sample,
)
child2 = Argument.create!(
  content: "Child: Freezing point is affected by pressure",
  source: Faker::Internet.url,
  # votes: (0..1000).to_a.sample,
  user: User.all.sample,
)

ArgumentParentChildRelationship.create!(child: child, parent: parent)
ArgumentParentChildRelationship.create!(child: child, parent: parent2)
ArgumentParentChildRelationship.create!(child: child2, parent: parent2)

10.times do
  argument = Argument.new(
    content: Faker::Quote.yoda,
    source: Faker::Internet.url,
    # votes: (0..1000).to_a.sample,
    user: User.all.sample
  )
  
  argument.save
end
