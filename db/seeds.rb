puts "seeding the instruments"
instr1 = Instrument.create name: "Bass"
instr2 = Instrument.create name: "Guitar"
instr3 = Instrument.create name: "Voice"
instr4 = Instrument.create name: "Keyboard"
instr5 = Instrument.create name: "Drums"
instr6 = Instrument.create name: "Sax"
instr7 = Instrument.create name: "Piano"
instr8 = Instrument.create name: "Trombone"
puts "finished seeding the instruments"
puts "seeding generes"
gnr1 = Genere.create name: "Rock"
gnr2 = Genere.create name: "Pop"
gnr3 = Genere.create name: "Folk"
gnr4 = Genere.create name: "Ska"
gnr5 = Genere.create name: "Reggae"
gnr6 = Genere.create name: "Jazz"
puts "finished seeding generes"
puts "seeding locations"

# generate random locations?
puts "making fake users"
(100).times do |u|
  user = User.create name: "User#{u}", email: "#{u}@gmail.com", password: "Andrea1234"
  user.location = Location.new(address: "#{rand(400)}, #{rand(50)}street, #{["manhattan","broklyn","queens"].sample}, new york")
    rand(1..3).times do |i|
      user.instruments << Instrument.where(id: rand(1..8))
    end
    rand(1..3).times do |g|
      user.generes << Instrument.where(id: rand(1..8))
    end
    user.save
end
puts "done with users"


