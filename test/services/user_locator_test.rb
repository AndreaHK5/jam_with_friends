require 'test_helper'

class UserLocatorTest < ActiveSupport::TestCase
  test "takes options on initialization" do
    options = {
      location: :location,
      user: :user,
      instruments: :instruments,
      genres: :genres,
      radius: :radius
    }

    user_location = UserLocator.new(options)
    assert_equal :location, user_location.location
    assert_equal :user, user_location.user
    assert_equal :instruments, user_location.instruments
    assert_equal :genres, user_location.genres
    assert_equal :radius, user_location.radius
  end

  test "finds local users" do
  i1 = Instrument.create name: "Bass"
  i2 = Instrument.create name: "Guitar"
  g1 = Genre.create name: "Rock"
  g2 = Genre.create name: "Pop"
  l1 = Location.new(address: "20 crooke avenue, 11226, new york")
  u1 = User.create name: "andrea", email:"1@gmail.com", password: "Andrea1234"
  u1.location = l1
  u1.genres << g1
  
  u2 = User.create name: "andrea", email:"1@gmail.com", password: "Andrea1234"
  u2.genres << g1
  

  location_search = "10 crooke avenue 11226, new york"
  options = {
      location: location_search,
      radius: 20,
      user: u1,
      instruments: [i1,i2],
      genres: [g1,g2]
      }


  user_location = UserLocator.new(options)

  result_users = user_location.call

  assert_equal 1, result_users.count
  assert_equal u2, result_users.first
  assert_equal i1, result_users.first.instruments.first

  end
end
