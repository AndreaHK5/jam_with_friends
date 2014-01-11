class HomeController < ApplicationController
  def index
    if user_signed_in?
      if current_user.location == nil
        @location_search = current_location
      else
        @location_search = current_user.location.address
      end
    else
      @location_search = current_location
    end
    @locations = Location.near(@location_search)
    @users = @locations.each.collect {|l| l.user}
    @users.delete(current_user)
    @users = @users.paginate(:page => params[:page], :per_page => 6)
    prepare_hash_for_map
    @instruments_current = []
    @genres_current = []
    # @users =[User.first]
    # @instruments = [Instrument.first]
    # @genres = [Genre.first]
    # @location_search = "20 crooke ave 11226 ny"

  end
end
