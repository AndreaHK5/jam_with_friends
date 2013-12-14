puts "seeding the instruments"
instr1 = Instrument.create name: "bass"
instr2 = Instrument.create name: "guitar"
instr3 = Instrument.create name: "voice"
instr4 = Instrument.create name: "keyboard"
instr5 = Instrument.create name: "drums"
instr6 = Instrument.create name: "sax"
puts "finished seeding the instruments"
puts "seeding generes"
gnr1 = Genere.create name: "rock"
gnr2 = Genere.create name: "pop"
gnr3 = Genere.create name: "folk"
gnr4 = Genere.create name: "ska"
gnr5 = Genere.create name: "reggae"
gnr6 = Genere.create name: "jazz"
puts "finished seeding generes"
puts "seeding locations"
loc1 = Location.create address: "20 crooke avenue, 11226 NY", radius: 25
loc2 = Location.create address: "32 avenue of the americas, 10013, NY", radius: 25
loc3 = Location.create address: "915 broadway, manhatta, new york", radius: 25
loc4 = Location.create address: "2 hill farm road, W10 6dn London UK", radius: 25
loc5 = Location.create address: "madison square garden, new york", radius: 25
puts "finished seeding locations"
puts "seeding users"
usr1 = User.create :name => "User1", :email => "1@gmail.com", :password => "Andrea1234"
usr2 = User.create :name => "User2", :email => "2@gmail.com", :password => "Andrea1234"
usr3 = User.create :name => "User3", :email => "3@gmail.com", :password => "Andrea1234"
usr4 = User.create :name => "User4", :email => "4@gmail.com", :password => "Andrea1234"
usr5 = User.create :name => "User5", :email => "5@gmail.com", :password => "Andrea1234"
puts "finished seeding users"
puts "seeding insruments associations"
usr1.instruments << instr1
usr2.instruments << instr2
usr3.instruments << instr3
usr4.instruments << instr4
usr5.instruments << instr5
usr5.instruments << instr6
puts "finished seeding insruments associations"
puts "seeding generes associations"
usr1.generes << gnr1
usr2.generes << gnr2
usr3.generes << gnr3
usr4.generes << gnr4
usr5.generes << gnr5
usr5.generes << gnr6
puts "finished seeding generes associations"
puts "seeding locations"
usr1.location = loc1
usr2.location = loc2
usr3.location = loc3
usr4.location = loc4
usr5.location = loc5
puts "finisedh seeding locations"

