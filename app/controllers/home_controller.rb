class HomeController < ApplicationController
  def index
    if user_signed_in?
      if current_user.location == nil
        @location = Location.first        
      else
        @location = current_user.location
      end
    else
      @location = Location.first
    end
    @locations = @location.nearbys(20)
    @instruments = Instrument.all
    @generes = Genere.all
    @users = @locations.collect {|d| d.user}
  end
end
