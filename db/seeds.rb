puts "seeding the instruments"
Instrument.create name: "Bass"
Instrument.create name: "Guitar"
Instrument.create name: "Voice"
Instrument.create name: "Keyboard"
Instrument.create name: "Drums"
Instrument.create name: "Sax"
Instrument.create name: "Piano"
Instrument.create name: "Trombone"
puts "finished seeding the instruments"
puts "seeding generes"
Genere.create name: "Rock"
Genere.create name: "Pop"
Genere.create name: "Folk"
Genere.create name: "Ska"
Genere.create name: "Reggae"
Genere.create name: "Jazz"
Genere.create name: "Country"
Genere.create name: "Funk"

puts "finished seeding generes"
puts "seeding locations"
# generate random locations?
puts "making fake users"
(100).times do |u|
  user = User.create name: "User#{u+1}", email: "#{u+1}@gmail.com", password: "Andrea1234"
  user.location = Location.new(address: "#{rand(400)}, #{rand(50)}street, #{["manhattan","brooklyn","queens"].sample}, new york")
    instruments =*(1..8)
    rand(1..3).times do |i|
      user.instruments << Instrument.where(id: instruments.delete_at(rand(instruments.length)))
    end
    user.instrxps.each do |iexp|
      iexp.since = rand(1999..2013)
      iexp.save
    end
    generes =*(1..8)
    rand(1..3).times do |g|
      user.generes << Genere.where(id: generes.delete_at(rand(generes.length)))
    end
    user.pers_picture = "andrea.jpg"
    user.save
end
puts "done with users"


