# Create users

admin = User.create(
  first_name: 'Admin', last_name: 'Admin', email: 'admin@admin.com',
  password: 'adminadmin', role: 'admin'
)

user = User.create(
  first_name: 'User', last_name: 'User', email: 'user@user.com',
  password: 'useruser', role: 'user'
)

User.create(
  first_name: 'Guest', last_name: 'Guest', email: 'guest@guest.com',
  password: 'guestguest', role: 'guest'
)

# Create events

event1 = Event.create(
  name: 'Birthday party', description: 'We gonna rock', location: 'London',
  date: '15.05.2019', user: user
)

event2 = Event.create(
  name: 'Road trip', description: 'Fear and Loathing', location: 'LasVegas',
  date: '11.01.2016', user: user
)

event3 = Event.create(
  name: 'Battle for the Death Star', description: 'May force be with you',
  location: 'Somewhere in galaxy', date: '13.03.3000', user: admin
)

# Create items

['The Cake', 'Birthday Centerpiece', 'Streamers', 'Birthday Banner', 'Scene Setters', 'Cutouts',
'Hanging Decorations', 'Birthday Confetti', 'Hot Dog Machine'].each { |description|
  Item.create(description: description, event: event1)
}

['Map', 'Car', 'Toiletries', 'Camera', 'Two bags of grass', 'Seventy-five pellets of mescaline',
'A case of Budweiser', 'A pint of raw ether'].each { |description|
  Item.create(description: description, event: event2)
}

['25 alive Jedis', '6 T-65 X-wing starfighters', '2 R-22 Spearhead starfighters', 'Millennium Falcon',
'50 MC80 Star Cruisers', 'EF76 Nebulon-B escort frigates', 'The Force'].each { |description|
  Item.create(description: description, event: event3)
}
