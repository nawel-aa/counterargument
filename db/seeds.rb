require "faker"

# Argument.all.each do |a|
#   a.argument_id = nil
#   a.save
# end
Vote.destroy_all
ArgumentParentChildRelationship.destroy_all
TagsArgument.destroy_all
Tag.destroy_all
# Reindexing algolia
Argument.clear_index!
Argument.destroy_all
Argument.reindex!
User.destroy_all


emails = %w[nawel@email.com patrick@email.com nooshin@email.com tatiana@email.com JasonBigHands@email.com spud@email.com jadam@email.com brick@email.com trumane@email.com jst@email.com]

puts "Generating users..."
emails.each do |email|
  user = User.new(email: email, password: 123456 )
  user.nickname = user.email.match(/.+?(?=@)/).to_s
  user.save!
end

puts "Generating tags..."
tag_names = ["Politics", "Global Warming", "Religion", "Vaccination", "BLM", "COVID-19", "Environment"]
tag_names.each do |tag_name|
  Tag.create!(name: tag_name)
end

puts "Generating arguments..."
# parent = Argument.create!(
#   content: "Global warming is not real",
#   source: Faker::Internet.url,
#   # votes: (0..1000).to_a.sample,
#   user: User.all.sample
# )
# parent2 = Argument.create!(
#   content: "Global overpopulation is a myth",
#   source: Faker::Internet.url,
#   # votes: (0..1000).to_a.sample,
#   user: User.all.sample
# )
# child = Argument.create!(
#   content: "Global temperature is rising",
#   source: Faker::Internet.url,
#   # votes: (0..1000).to_a.sample,
#   user: User.all.sample,
# )
# child2 = Argument.create!(
#   content: "A lot of countries have famines",
#   source: Faker::Internet.url,
#   # votes: (0..1000).to_a.sample,
#   user: User.all.sample,
# )

# ArgumentParentChildRelationship.create!(child: child, parent: parent)
# ArgumentParentChildRelationship.create!(child: child2, parent: parent2)
# TagsArgument.create!(argument: parent, tag: Tag.find_by(name: "Politics"))
# TagsArgument.create!(argument: parent, tag: Tag.find_by(name: "Environment"))
# TagsArgument.create!(argument: parent, tag: Tag.find_by(name: "Global Warming"))
# TagsArgument.create!(argument: parent2, tag: Tag.find_by(name: "Politics"))
# TagsArgument.create!(argument: child2, tag: Tag.find_by(name: "Politics"))
# TagsArgument.create!(argument: child, tag: Tag.find_by(name: "Global Warming"))
# TagsArgument.create!(argument: child, tag: Tag.find_by(name: "Environment"))
# TagsArgument.create!(argument: child, tag: Tag.find_by(name: "Politics"))

# 10.times do
#   argument = Argument.new(
#     content: Faker::Quote.yoda,
#     source: Faker::Internet.url,
#     # votes: (0..1000).to_a.sample,
#     user: User.all.sample
#   )

#   argument.save
#   TagsArgument.create!(argument: argument, tag: Tag.all.sample)
# end

zoo_parent = Argument.create!(
  content: "Zoos should be banned",
  source: Faker::Internet.url,
  user: User.all.sample
  )

zoo_violate_animal = Argument.create!(
  content: "Zoos violate animal rights and cause suffering to animals",
  source: Faker::Internet.url,
  user: User.all.sample
  )
zoo_black_market = Argument.create!(
  content: "Zoos can be a source of animals ' black market",
  source: Faker::Internet.url,
  user: User.all.sample
  )
zoo_conservation = Argument.create!(
  content: "Zoos play a critical role in the conservation of endangered species",
  source: Faker::Internet.url,
  user: User.all.sample
  )

ArgumentParentChildRelationship.create!(child: zoo_violate_animal, parent: zoo_parent)
ArgumentParentChildRelationship.create!(child: zoo_black_market, parent: zoo_parent)
ArgumentParentChildRelationship.create!(child: zoo_conservation, parent: zoo_black_market)
TagsArgument.create!(argument: zoo_parent, tag: Tag.find_by(name: "Environment"))

languages_parent = Argument.create!(
  content: "The fewer languages there are, the better the world is",
  source: Faker::Internet.url,
  user: User.all.sample
  )
reducing_languages = Argument.create!(
  content: "Reducing the number of languages has socioeconomic advantages.",
  source: Faker::Internet.url,
  user: User.all.sample
)
lan_cognitive_benefits = Argument.create!(
  content: "Learning more languages has cognitive benefits.",
  source: "https://www.weforum.org/agenda/2017/04/the-benefits-of-speaking-more-than-one-language",
  user: User.all.sample
)
 wider_vocabulary = Argument.create!(
  content: "People who speak only one language tend to maintain a wider vocabulary than people who speak more than one language",
  source: Faker::Internet.url,
  user: User.all.sample
)
 economic_growth = Argument.create!(
  content: "Loss of languages is shown to correlate with economic growth.",
  source: "https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4173687/",
  user: User.all.sample
)
ArgumentParentChildRelationship.create!(child: reducing_languages, parent: languages_parent)
ArgumentParentChildRelationship.create!(child: lan_cognitive_benefits, parent: languages_parent)
ArgumentParentChildRelationship.create!(child: wider_vocabulary, parent: lan_cognitive_benefits)
ArgumentParentChildRelationship.create!(child: economic_growth, parent: reducing_languages)

TagsArgument.create!(argument: economic_growth, tag: Tag.find_by(name: "Politics"))




