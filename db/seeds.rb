require "faker"

Vote.destroy_all
ArgumentParentChildRelationship.destroy_all
TagsArgument.destroy_all
Tag.destroy_all
# Reindexing algolia
Argument.clear_index!
Argument.destroy_all
Argument.reindex!
User.destroy_all


emails = %w[nawel@email.com patrick@email.com nooshin@email.com tatiana@email.com stephane@email.com richard@email.com martin@email.com kristyna@email.com tim@email.com JasonBigHands@email.com spud@email.com jadam@email.com brick@email.com trumane@email.com jst@email.com]

puts "Generating users..."
emails.each do |email|
  user = User.new(email: email, password: 123456 )
  user.nickname = user.email.match(/.+?(?=@)/).to_s
  user.save!
end

tatiana = User.find_by(email:"tatiana@email.com")
tatiana.profile_picture.attach(io: File.open("app/assets/images/tatiana.png"), filename: 'picture.png')
tatiana.save!


nawel = User.find_by(email:"nawel@email.com")
nawel.profile_picture.attach(io: File.open("app/assets/images/nawel.png"), filename: 'picture.png')
nawel.save!

noosh = User.find_by(email:"nooshin@email.com")
noosh.profile_picture.attach(io: File.open("app/assets/images/noosh.png"), filename: 'picture.png')
noosh.save!

patrick = User.find_by(email:"patrick@email.com")
patrick.profile_picture.attach(io: File.open("app/assets/images/patrick.png"), filename: 'picture.png')
patrick.save!

stephane = User.find_by(email:"stephane@email.com")
stephane.profile_picture.attach(io: File.open("app/assets/images/stephane.png"), filename: 'picture.png')
stephane.save!

richard = User.find_by(email:"richard@email.com")
richard.profile_picture.attach(io: File.open("app/assets/images/richard.png"), filename: 'picture.png')
richard.save!

martin = User.find_by(email:"martin@email.com")
martin.profile_picture.attach(io: File.open("app/assets/images/martin.png"), filename: 'picture.png')
martin.save!

kristyna = User.find_by(email:"kristyna@email.com")
kristyna.profile_picture.attach(io: File.open("app/assets/images/kristyna.png"), filename: 'picture.png')
kristyna.save!

tim = User.find_by(email:"tim@email.com")
tim.profile_picture.attach(io: File.open("app/assets/images/tim.png"), filename: 'picture.png')
tim.save!

puts "Generating tags..."
tag_names = ["Politics", "Global Warming", "Religion", "Vaccination", "BLM", "COVID-19", "Environment", "Science", "Equality", "Vegan", "Animal"]
tag_names.each do |tag_name|
  Tag.create!(name: tag_name)
end

puts "Generating arguments..."

# Title 1: Global Warming/Cars

cars_parent = Argument.create!(
  content: "Private cars should be forbidden in large cities",
  source: Faker::Internet.url,
  user: User.find_by(email: "patrick@email.com")
)
cars_cities = Argument.create!(
  content: "Cars make cities less habitable.",
  source: Faker::Internet.url,
  user: User.find_by(email: "nawel@email.com")
)
cars_only_transport = Argument.create!(
  content: "No other form of transportation is as flexible as cars",
  source: Faker::Internet.url,
  user: User.find_by(email:"martin@email.com")
)
bad_for_environments = Argument.create!(
  content: "Cars are bad for the environment.",
  source: Faker::Internet.url,
  user: User.find_by(email: "tatiana@email.com")
)
bad_public_transport = Argument.create!(
  content: "Many public transportation systems are currently inadequate.",
  source: Faker::Internet.url,
  user: User.find_by(email: "richard@email.com")
)
expensive = Argument.create!(
  content: "Cars are extremely expensive to run: they only offer flexibility to the well-off.",
  source: Faker::Internet.url,
  user: User.find_by(email: "patrick@email.com")
)
prefer_cars = Argument.create!(
  content: "Certain groups of people cannot easily travel by public transport, even if provision is excellent.",
  source: Faker::Internet.url,
  user: User.find_by(email: "kristyna@email.com")
)
sydney_insurance = Argument.create!(
  content: "The average cost of car insurance in Sydney is 1142.55 AUD per year.",
  source: Faker::Internet.url,
  user: User.find_by(email: "nawel@email.com")
)
bikes = Argument.create!(
  content: "Bikes are WAY more flexible than cars.  They don't get stuck in traffic!",
  source: Faker::Internet.url,
  user: User.find_by(email: "patrick@email.com")
)
no_bikes = Argument.create!(
  content: "Bike are more flexible under defined distances, over long distance the time taken to travel negates the advantage of a bicycle.",
  source: Faker::Internet.url,
  user: User.find_by(email: "nooshin@email.com")
)

demand_for_publictransport = Argument.create!(
  content: "A higher demand on public transport would incentivise the state to invest in public transport",
  source: Faker::Internet.url,
  user: User.find_by(email: "patrick@email.com")
)
pollution = Argument.create!(
  content: "The pollution caused by cars make the air less breathable.",
  source: Faker::Internet.url,
  user: User.find_by(email: "tatiana@email.com")
)

noise = Argument.create!(
  content: "Cars make the overall environment of cities less pleasant as they cause a lot of noise.",
  source: Faker::Internet.url,
  user: User.find_by(email: "tatiana@email.com")
)
space = Argument.create!(
  content: "Cars take up a lot of space.",
  source: Faker::Internet.url,
  user: User.find_by(email: "tatiana@email.com")
)
disable_users = Argument.create!(
  content: "Some disabled people require cars to transport them.",
  source: Faker::Internet.url,
  user: User.find_by(email: "stephane@email.com")
)

ArgumentParentChildRelationship.create!(child: cars_cities, parent: cars_parent)
ArgumentParentChildRelationship.create!(child: cars_only_transport, parent: cars_parent)
ArgumentParentChildRelationship.create!(child: bad_for_environments, parent: cars_parent)
ArgumentParentChildRelationship.create!(child: bad_public_transport, parent: cars_parent)
ArgumentParentChildRelationship.create!(child: expensive, parent: cars_only_transport)
ArgumentParentChildRelationship.create!(child: prefer_cars, parent: cars_only_transport)
ArgumentParentChildRelationship.create!(child:sydney_insurance, parent: expensive)
ArgumentParentChildRelationship.create!(child: bikes, parent: cars_only_transport)
ArgumentParentChildRelationship.create!(child: no_bikes, parent: bikes)
ArgumentParentChildRelationship.create!(child: demand_for_publictransport, parent: bad_public_transport)
ArgumentParentChildRelationship.create!(child: pollution, parent: cars_cities)
ArgumentParentChildRelationship.create!(child: noise, parent: cars_cities)
ArgumentParentChildRelationship.create!(child: space, parent: cars_cities)
ArgumentParentChildRelationship.create!(child: disable_users, parent: prefer_cars)

# Title 1: Global Warming/Cars Tags
TagsArgument.create!(argument: cars_parent, tag: Tag.find_by(name: "Environment"))
TagsArgument.create!(argument: cars_cities, tag: Tag.find_by(name: "Environment"))
TagsArgument.create!(argument: bad_for_environments, tag: Tag.find_by(name: "Environment"))
TagsArgument.create!(argument: cars_only_transport, tag: Tag.find_by(name: "Environment"))
TagsArgument.create!(argument: pollution, tag: Tag.find_by(name: "Environment"))
TagsArgument.create!(argument: bikes, tag: Tag.find_by(name: "Environment"))
TagsArgument.create!(argument: expensive, tag: Tag.find_by(name: "Environment"))
TagsArgument.create!(argument: cars_parent, tag: Tag.find_by(name: "Global Warming"))
TagsArgument.create!(argument: cars_only_transport, tag: Tag.find_by(name: "Global Warming"))
TagsArgument.create!(argument: pollution, tag: Tag.find_by(name: "Global Warming"))
TagsArgument.create!(argument: cars_cities, tag: Tag.find_by(name: "Global Warming"))
TagsArgument.create!(argument: noise, tag: Tag.find_by(name: "Global Warming"))
TagsArgument.create!(argument: space, tag: Tag.find_by(name: "Global Warming"))
TagsArgument.create!(argument: no_bikes, tag: Tag.find_by(name: "Global Warming"))
TagsArgument.create!(argument: prefer_cars, tag: Tag.find_by(name: "Global Warming"))
TagsArgument.create!(argument: demand_for_publictransport, tag: Tag.find_by(name: "Global Warming"))
TagsArgument.create!(argument: demand_for_publictransport, tag: Tag.find_by(name: "Environment"))
TagsArgument.create!(argument: disable_users, tag: Tag.find_by(name: "Equality"))

# Title 2: Vaccination

covid_vaccine_parent = Argument.create!(
  content: "COVID-19 Vaccines should be Mandatory",
  source: Faker::Internet.url,
  user: User.all.sample
)

herd_immunity = Argument.create!(
  content: "Herd immunity is best developed through a mandatory vaccination policy",
  source: Faker::Internet.url,
  user: User.all.sample
)

inequalities = Argument.create!(
  content: "A mandatory vaccine policy would vastly increase already present inequalities in the treatment and prevention of Covid-19",
  source: "https://medicalxpress.com/news/2020-07-covid-vaccine.html",
  user: User.all.sample
)

prioritized_distribution = Argument.create!(
  content: "Differences over how to distribute the vaccine in a mandatory system will lead to some people being prioritized over others.",
  source: Faker::Internet.url,
  user: User.all.sample
)

unnecessary_deaths = Argument.create!(
  content: "Certain groups are already at higher risk for contracting COVID-19. Not prioritizing these groups may lead to unnecessary deaths.",
  source: Faker::Internet.url,
  user: User.all.sample
)

community_immunity = Argument.create!(
  content: "Herd immunity is the most vital part of protecting a community from an infectious disease",
  source: Faker::Internet.url,
  user: User.all.sample
)

not_every_vaccine = Argument.create!(
  content: "Not every vaccine creates community immunity.",
  source: Faker::Internet.url,
  user: User.all.sample
)

ArgumentParentChildRelationship.create!(child: inequalities, parent: covid_vaccine_parent)
ArgumentParentChildRelationship.create!(child: herd_immunity, parent: covid_vaccine_parent)
ArgumentParentChildRelationship.create!(child: prioritized_distribution, parent: inequalities)
ArgumentParentChildRelationship.create!(child: unnecessary_deaths, parent: inequalities)
ArgumentParentChildRelationship.create!(child: community_immunity, parent: herd_immunity)
ArgumentParentChildRelationship.create!(child: not_every_vaccine, parent: herd_immunity)

# Title 2: Vaccination Tags
TagsArgument.create!(argument: inequalities, tag: Tag.find_by(name: "Vaccination"))
TagsArgument.create!(argument: unnecessary_deaths, tag: Tag.find_by(name: "Vaccination"))
TagsArgument.create!(argument: covid_vaccine_parent, tag: Tag.find_by(name: "Vaccination"))
TagsArgument.create!(argument: herd_immunity, tag: Tag.find_by(name: "Vaccination"))
TagsArgument.create!(argument: prioritized_distribution, tag: Tag.find_by(name: "Vaccination"))
TagsArgument.create!(argument: community_immunity, tag: Tag.find_by(name: "Vaccination"))
TagsArgument.create!(argument: not_every_vaccine, tag: Tag.find_by(name: "Vaccination"))
TagsArgument.create!(argument: not_every_vaccine, tag: Tag.find_by(name: "COVID-19"))
TagsArgument.create!(argument: community_immunity, tag: Tag.find_by(name: "Equality"))
TagsArgument.create!(argument: unnecessary_deaths, tag: Tag.find_by(name: "COVID-19"))
TagsArgument.create!(argument: covid_vaccine_parent, tag: Tag.find_by(name: "COVID-19"))
TagsArgument.create!(argument: inequalities, tag: Tag.find_by(name: "Politics"))
TagsArgument.create!(argument: unnecessary_deaths, tag: Tag.find_by(name: "Equality"))


# Title 3: BLM

blm_parent = Argument.create!(
  content: "“All Lives Matter is a racist affront to BLM”.",
  source: Faker::Internet.url,
  user: User.all.sample
)

police_brutality = Argument.create!(
  content: "All Lives Matter does not address the police brutality",
  source: Faker::Internet.url,
  user: User.all.sample
)

all_lives_matter = Argument.create!(
  content: "All lives Matter is not racist; if anything, it's more inclusive.",
  source: Faker::Internet.url,
  user: User.all.sample
)

ethnic_minorities = Argument.create!(
  content: "All ethnic minorities are then more invited, including Latin American and Asian.",
  source: Faker::Internet.url,
  user: User.all.sample
)

asian_latin = Argument.create!(
  content: "Asians and Latinx people arent targeted by police for the worst abuse of brutality and over policing across the country",
  source: Faker::Internet.url,
  user: User.all.sample
)

objective_totality = Argument.create!(
  content: "All Lives Matter views itself as an objective totality. The deployment of this seemingly neutral image perpetuates the racial hierarchies that BLM is attempting to dismantle.",
  source: Faker::Internet.url,
  user: User.all.sample
)

blue_lives_matter = Argument.create!(
  content: "Police have a very poor reputation. Blue Lives Matter, like All Lives Matter, recognises the difficulties facing the police forces.",
  source: Faker::Internet.url,
  user: User.all.sample
)

instead = Argument.create!(
  content: "If black lives matter was instead named All lives matter, They would be addressing those issues.",
  source: Faker::Internet.url,
  user: User.all.sample
)

ArgumentParentChildRelationship.create!(child: police_brutality, parent: blm_parent)
ArgumentParentChildRelationship.create!(child: all_lives_matter, parent: blm_parent)
ArgumentParentChildRelationship.create!(child: ethnic_minorities, parent: all_lives_matter)
ArgumentParentChildRelationship.create!(child: asian_latin, parent: ethnic_minorities)
ArgumentParentChildRelationship.create!(child: objective_totality, parent: all_lives_matter)
ArgumentParentChildRelationship.create!(child: blue_lives_matter, parent: police_brutality)
ArgumentParentChildRelationship.create!(child: instead, parent: police_brutality)

# Title 3: BLM Tags
TagsArgument.create!(argument: blm_parent, tag: Tag.find_by(name: "BLM"))
TagsArgument.create!(argument: blm_parent, tag: Tag.find_by(name: "Equality"))
TagsArgument.create!(argument: police_brutality, tag: Tag.find_by(name: "BLM"))
TagsArgument.create!(argument: all_lives_matter, tag: Tag.find_by(name: "BLM"))
TagsArgument.create!(argument: ethnic_minorities, tag: Tag.find_by(name: "BLM"))
TagsArgument.create!(argument: asian_latin, tag: Tag.find_by(name: "BLM"))
TagsArgument.create!(argument: objective_totality, tag: Tag.find_by(name: "BLM"))
TagsArgument.create!(argument: blue_lives_matter, tag: Tag.find_by(name: "BLM"))
TagsArgument.create!(argument: instead, tag: Tag.find_by(name: "BLM"))
TagsArgument.create!(argument: instead, tag: Tag.find_by(name: "Politics"))
TagsArgument.create!(argument: all_lives_matter, tag: Tag.find_by(name: "Equality"))
TagsArgument.create!(argument: asian_latin, tag: Tag.find_by(name: "Politics"))


# Title 4: Religion
religion_parent = Argument.create!(
  content: "Religion has been a good thing for humankind",
  source: Faker::Internet.url,
  user: User.all.sample
)

charity_work = Argument.create!(
  content: "Religion has motivated numerous selfless acts such as volunteering and charity.",
  source: Faker::Internet.url,
  user: User.all.sample
)

terrible_acts = Argument.create!(
  content: "People have been led to do terrible things in the name of religion.",
  source: Faker::Internet.url,
  user: User.all.sample
)

help_communities = Argument.create!(
  content: "Religious organizations make it easier for people to come together and help their communities",
  source: Faker::Internet.url,
  user: User.all.sample
)

non_religious_communities = Argument.create!(
  content: "This is a community you're referring to, not religion.  There are many non-religious communities in my town that facilitate helping others.",
  source: Faker::Internet.url,
  user: User.all.sample
)

intentional_misuse = Argument.create!(
  content: "Religion should not be blamed for its intentional or unintentional misuse",
  source: Faker::Internet.url,
  user: User.all.sample
)

ego = Argument.create!(
  content: "No religion motivates people to do terrible things. People do terrible things to satisfy their ego",
  source: Faker::Internet.url,
  user: User.all.sample
)

religion_teachings = Argument.create!(
  content: "Many religious teachings promote violence.",
  source: Faker::Internet.url,
  user: User.all.sample
)

ArgumentParentChildRelationship.create!(child: charity_work, parent: religion_parent)
ArgumentParentChildRelationship.create!(child: terrible_acts, parent: religion_parent)
ArgumentParentChildRelationship.create!(child: help_communities, parent: charity_work)
ArgumentParentChildRelationship.create!(child: non_religious_communities, parent: help_communities)
ArgumentParentChildRelationship.create!(child: intentional_misuse, parent: terrible_acts)
ArgumentParentChildRelationship.create!(child: ego, parent: intentional_misuse)
ArgumentParentChildRelationship.create!(child: religion_teachings, parent: ego)

# Title 4: Religion Tags
TagsArgument.create!(argument: religion_parent, tag: Tag.find_by(name: "Religion"))
TagsArgument.create!(argument: charity_work, tag: Tag.find_by(name: "Religion"))
TagsArgument.create!(argument: help_communities, tag: Tag.find_by(name: "Religion"))
TagsArgument.create!(argument: non_religious_communities, tag: Tag.find_by(name: "Religion"))
TagsArgument.create!(argument: intentional_misuse, tag: Tag.find_by(name: "Religion"))
TagsArgument.create!(argument: ego, tag: Tag.find_by(name: "Religion"))
TagsArgument.create!(argument: help_communities, tag: Tag.find_by(name: "Politics"))
TagsArgument.create!(argument: religion_teachings, tag: Tag.find_by(name: "Religion"))
TagsArgument.create!(argument: terrible_acts, tag: Tag.find_by(name: "Religion"))
TagsArgument.create!(argument: ego, tag: Tag.find_by(name: "Politics"))

# Title 5: geneticalli modified food
genetically_modified_food_parent = Argument.create!(
  content: "The sale of genetically modified food should be banned.",
  source: Faker::Internet.url,
  user: User.all.sample
)

threaten_biodiversity = Argument.create!(
  content: "Genetically modified crops threaten biodiversity.",
  source: Faker::Internet.url,
  user: User.all.sample
)

world_hunger = Argument.create!(
  content: "Genetically modified crops can work towards mitigating world hunger.",
  source: Faker::Internet.url,
  user: User.all.sample
)

climate_change = Argument.create!(
  content: "Climate change is predicted to reduce nutrient levels in staple crops consumed by impoverished communities",
  source: "https://www.bbc.com/news/science-environment-27308720",
  user: User.all.sample
)

enough_food = Argument.create!(
  content: "The world already produces enough food to feed the global population.",
  source: Faker::Internet.url,
  user: User.all.sample
)
feed_the_globe = Argument.create!(
  content: "While we may produce enough food now, the United Nations predicts that by 2050, humans will need to produce 70 percent more food than we currently do in order to adequately feed the global population.",
  source: Faker::Internet.url,
  user: User.all.sample
)
limiting_food_waste = Argument.create!(
  content: "Limiting food waste globally is key to solving world hunger, potentially reducing the need for more food production by 60%.",
  source: Faker::Internet.url,
  user: User.all.sample
)

ArgumentParentChildRelationship.create!(child: threaten_biodiversity, parent: genetically_modified_food_parent)
ArgumentParentChildRelationship.create!(child: world_hunger, parent: genetically_modified_food_parent)
ArgumentParentChildRelationship.create!(child: climate_change, parent: world_hunger)
ArgumentParentChildRelationship.create!(child: enough_food, parent: world_hunger)
ArgumentParentChildRelationship.create!(child: feed_the_globe, parent: enough_food)
ArgumentParentChildRelationship.create!(child: limiting_food_waste, parent: enough_food)

TagsArgument.create!(argument: genetically_modified_food_parent, tag: Tag.find_by(name: "Politics"))
TagsArgument.create!(argument: genetically_modified_food_parent, tag: Tag.find_by(name: "Environment"))
TagsArgument.create!(argument: world_hunger, tag: Tag.find_by(name: "Politics"))
TagsArgument.create!(argument: world_hunger, tag: Tag.find_by(name: "Equality"))
TagsArgument.create!(argument: climate_change, tag: Tag.find_by(name: "Environment"))
TagsArgument.create!(argument: climate_change, tag: Tag.find_by(name: "Global Warming"))
TagsArgument.create!(argument: enough_food, tag: Tag.find_by(name: "Equality"))
TagsArgument.create!(argument: limiting_food_waste, tag: Tag.find_by(name: "Environment"))
TagsArgument.create!(argument: limiting_food_waste, tag: Tag.find_by(name: "Global Warming"))
TagsArgument.create!(argument: feed_the_globe, tag: Tag.find_by(name: "Equality"))


# Title 6: zoo & animals

zoo_parent = Argument.create!(
  content: "Zoos are a good way to experience wildlife.",
  source: Faker::Internet.url,
  user: User.find_by(email: "tim@email.com")
)
zoo_educational = Argument.create!(
  content: "Zoos are not even educational, people visit zoos to enjoy the nature and animals",
  source: Faker::Internet.url,
  user: User.find_by(email: "martin@email.com")
)
zoo_educate = Argument.create!(
  content: "Zoos actually play a huge role in educating people to habitat preservation",
  source: Faker::Internet.url,
  user: User.find_by(email: "richard@email.com")
)
eco_parks = Argument.create!(
  content: "Educational benefits and research can be equally achieved by Eco Parks!",
  source: Faker::Internet.url,
  user: User.find_by(email: "stephane@email.com")
)

zoo_violate_animal = Argument.create!(
  content: "Zoos violate animal rights and cause suffering to animals",
  source: Faker::Internet.url,
  user: User.find_by(email:"patrick@email.com")
)
zoo_black_market = Argument.create!(
  content: "Zoos can be a source of animals' black market",
  source: Faker::Internet.url,
  user: User.find_by(email:"kristyna@email.com")
)
zoo_conservation = Argument.create!(
  content: "Zoos play a critical role in the conservation of endangered species",
  source: Faker::Internet.url,
  user: User.find_by(email:"jadam@email.com")
)
brazil_black_market = Argument.create!(
  content: "In Brazil, zoos do “Animal laundering” and provide false certificates, claiming that animals were born in captivity.",
  source: "https://wildwelfare.org/portfolio/animal-welfare-in-brazilian-zoos/",
  user: User.all.sample
)
pet_trade = Argument.create!(
  content: "The exotic pet trade, which is highly unregulated, is a multi-billion dollar industry, second only to drugs and weapons on the black market",
  source: Faker::Internet.url,
  user: User.all.sample
)
no_zoo = Argument.create!(
  content: "Conservation can be achieved without keeping animals in artificial captive environments.",
  source: Faker::Internet.url,
  user: User.all.sample
)
yes_zoo = Argument.create!(
  content: "Zoos contribute financially to conservation, both at their facilities and in wild habitats.",
  source: Faker::Internet.url,
  user: User.find_by(email:"jadam@email.com")
)
national_parks = Argument.create!(
  content: "For example, national parks play critical roles in conservation.",
  source: Faker::Internet.url,
  user: User.all.sample
)

animal_suffering = Argument.create!(
  content: "Zoos cause suffering to animals.",
  source: Faker::Internet.url,
  user: User.all.sample
)
natural_environment = Argument.create!(
  content: "Zoos cannot replicate the natural environment of animals.",
  source: Faker::Internet.url,
  user: User.all.sample
)

ArgumentParentChildRelationship.create!(child: zoo_educational, parent: zoo_parent)
ArgumentParentChildRelationship.create!(child: zoo_educate, parent: zoo_educational)
ArgumentParentChildRelationship.create!(child: zoo_violate_animal, parent: zoo_parent)
ArgumentParentChildRelationship.create!(child: zoo_black_market, parent: zoo_parent)
ArgumentParentChildRelationship.create!(child: animal_suffering, parent: zoo_parent)
ArgumentParentChildRelationship.create!(child: eco_parks, parent: zoo_educate)
ArgumentParentChildRelationship.create!(child: zoo_conservation, parent: zoo_black_market)
ArgumentParentChildRelationship.create!(child: brazil_black_market, parent: zoo_black_market)
ArgumentParentChildRelationship.create!(child: pet_trade, parent: zoo_black_market)
ArgumentParentChildRelationship.create!(child: no_zoo, parent: zoo_conservation)
ArgumentParentChildRelationship.create!(child: yes_zoo, parent: zoo_conservation)
ArgumentParentChildRelationship.create!(child: national_parks, parent: no_zoo)
ArgumentParentChildRelationship.create!(child: natural_environment, parent: animal_suffering)

TagsArgument.create!(argument: zoo_parent, tag: Tag.find_by(name: "Animal"))
TagsArgument.create!(argument: zoo_violate_animal, tag: Tag.find_by(name: "Animal"))
TagsArgument.create!(argument: zoo_black_market, tag: Tag.find_by(name: "Animal"))
TagsArgument.create!(argument: animal_suffering, tag: Tag.find_by(name: "Animal"))
TagsArgument.create!(argument: zoo_conservation, tag: Tag.find_by(name: "Animal"))
TagsArgument.create!(argument: brazil_black_market, tag: Tag.find_by(name: "Animal"))
TagsArgument.create!(argument: pet_trade, tag: Tag.find_by(name: "Animal"))
TagsArgument.create!(argument: no_zoo, tag: Tag.find_by(name: "Animal"))
TagsArgument.create!(argument: yes_zoo, tag: Tag.find_by(name: "Animal"))
TagsArgument.create!(argument: national_parks, tag: Tag.find_by(name: "Animal"))
TagsArgument.create!(argument: natural_environment, tag: Tag.find_by(name: "Animal"))
TagsArgument.create!(argument: zoo_parent, tag: Tag.find_by(name: "Environment"))
TagsArgument.create!(argument: zoo_violate_animal, tag: Tag.find_by(name: "Equality"))
TagsArgument.create!(argument: zoo_black_market, tag: Tag.find_by(name: "Environment"))
TagsArgument.create!(argument: zoo_conservation, tag: Tag.find_by(name: "Environment"))
TagsArgument.create!(argument: brazil_black_market, tag: Tag.find_by(name: "Environment"))
TagsArgument.create!(argument: pet_trade, tag: Tag.find_by(name: "Environment"))
TagsArgument.create!(argument: natural_environment, tag: Tag.find_by(name: "Environment"))
TagsArgument.create!(argument: zoo_educate, tag: Tag.find_by(name: "Environment"))
TagsArgument.create!(argument: zoo_educate, tag: Tag.find_by(name: "Animal"))
TagsArgument.create!(argument: eco_parks, tag: Tag.find_by(name: "Animal"))
TagsArgument.create!(argument: eco_parks, tag: Tag.find_by(name: "Environment"))
TagsArgument.create!(argument: zoo_educational, tag: Tag.find_by(name: "Animal"))
TagsArgument.create!(argument: zoo_educational, tag: Tag.find_by(name: "Environment"))

# Title 7: languages
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
TagsArgument.create!(argument: lan_cognitive_benefits, tag: Tag.find_by(name: "Science"))
TagsArgument.create!(argument: reducing_languages, tag: Tag.find_by(name: "Environment"))

# Title 8: vegan

vegan_parent = Argument.create!(
  content: "All humans should be vegan.",
  source: Faker::Internet.url,
  user: User.find_by(email: "nooshin@email.com")
)

yes_vegan = Argument.create!(
  content: "A vegan society has environmental advantages",
  source: Faker::Internet.url,
  user: User.find_by(email: "tatiana@email.com")
)

no_vegan = Argument.create!(
  content: "Veganism is not feasible for lesser privileged societies or individuals",
  source: Faker::Internet.url,
  user: User.find_by(email: "nawel@email.com")
)

vegan_cheaper = Argument.create!(
  content: "A balanced vegetarian diet is cheaper than a balanced diet that includes meat.",
  source: Faker::Internet.url,
  user: User.find_by(email: "tatiana@email.com")
)

world_hunger_eradicated = Argument.create!(
  content: "If humanity turned vegan or vegetarian world hunger could be eradicated",
  source: Faker::Internet.url,
  user: User.find_by(email: "nooshin@email.com")
)


ArgumentParentChildRelationship.create!(child: yes_vegan, parent: vegan_parent)
ArgumentParentChildRelationship.create!(child: no_vegan, parent: vegan_parent)
ArgumentParentChildRelationship.create!(child: vegan_cheaper, parent: no_vegan)
ArgumentParentChildRelationship.create!(child: world_hunger_eradicated, parent: no_vegan)

TagsArgument.create!(argument: vegan_parent, tag: Tag.find_by(name: "Vegan"))
TagsArgument.create!(argument: yes_vegan, tag: Tag.find_by(name: "Vegan"))
TagsArgument.create!(argument: yes_vegan, tag: Tag.find_by(name: "Environment"))
TagsArgument.create!(argument: vegan_cheaper, tag: Tag.find_by(name: "Vegan"))
TagsArgument.create!(argument: world_hunger_eradicated, tag: Tag.find_by(name: "Vegan"))









