class HomeController < ApplicationController
  def index
    # if user_signed_in?
    #   if current_user.location == nil
    #     @location_search = current_location
    #   else
    #     @location_search = current_user.location.address
    #   end
    # else
    #   @location_search = current_location
    # end
    # @locations = Location.near(@location_search,2)
    # @users = @locations.each.collect {|l| l.user}
    # @users.delete(current_user)
    # prepare_hash_for_map
    # @instruments = Instrument.all
    # @generes = Genere.all

@users =[User.first]
@instruments = [Instrument.first]
@generes = [Genere.first]

  end
end
