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
puts "seeding genres"
Genre.create name: "Rock"
Genre.create name: "Pop"
Genre.create name: "Folk"
Genre.create name: "Ska"
Genre.create name: "Reggae"
Genre.create name: "Jazz"
Genre.create name: "Country"
Genre.create name: "Funk"

puts "finished seeding genres"
puts "seeding locations"
# generate random locations?
puts "making fake users"
(50).times do |u|
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
    genres =*(1..8)
    rand(1..3).times do |g|
      user.genres << Genre.where(id: genres.delete_at(rand(genres.length)))
    end
    # user.photo = Rails.root.joint("app","assets","images","userpic"+rand(1..12).to_s+".jpg")
    # user.photo = File.open(Rails.root.join(asset_path ("userpic"+rand(1..12).to_s+".jpg"))
    user.photo = File.open("#{Rails.root}/app/assets/images/userpic"+rand(1..12).to_s+".jpg")

    user.save
end
puts "done with users"


