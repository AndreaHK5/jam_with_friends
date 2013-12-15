class HomeController < ApplicationController
  def index
    if user_signed_in?
      @location = current_user.location
    else
      @location = Location.first
    end
    @locations = @location.nearbys(20)
    @instruments = Instrument.all
    @generes = Genere.all
    @users = @locations.collect {|d| d.user}
  end
end
