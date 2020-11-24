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

  10.times do
    argument = Argument.new(
      content: Faker::Quote.yoda,
      source: Faker::Internet.url,
      # votes: (0..1000).to_a.sample,
      user: User.all.sample
    )

    argument.save
  end
