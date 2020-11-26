require "faker"

# Argument.all.each do |a|
#   a.argument_id = nil
#   a.save
# end
Vote.destroy_all
ArgumentParentChildRelationship.destroy_all
TagsArgument.destroy_all
Tag.destroy_all
Argument.destroy_all
User.destroy_all


emails = %w[nawel@email.com patrick@email.com nooshin@email.com tatiana@email.com JasonBigHands@email.com spud@email.com jadam@email.com brick@email.com trumane@email.com jst@email.com]

puts "Generating users..."
emails.each do |email|
  user = User.new(email: email, password: 123456 )
  user.nickname = user.email.match(/.+?(?=@)/).to_s
  user.save!
end

puts "Generating tags..."
tag_names = ["Politics", "Global Warming", "Religion", "Vaccination", "BLM", "COVID-19"]
tag_names.each do |tag_name|
  Tag.create!(name: tag_name)
end

puts "Generating arguments..."
parent = Argument.create!(
  content: "The sun is hot",
  source: Faker::Internet.url,
  # votes: (0..1000).to_a.sample,
  user: User.all.sample
)
parent2 = Argument.create!(
  content: "Ice is cold",
  source: Faker::Internet.url,
  # votes: (0..1000).to_a.sample,
  user: User.all.sample
)
child = Argument.create!(
  content: "Temperature is subjective",
  source: Faker::Internet.url,
  # votes: (0..1000).to_a.sample,
  user: User.all.sample,
)
child2 = Argument.create!(
  content: "Freezing point is affected by pressure",
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
  TagsArgument.create!(argument: argument, tag: Tag.all.sample)
end
