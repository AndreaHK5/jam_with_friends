class HomeController < ApplicationController
  def index
    if user_signed_in?
      @location = current_user.location
    else
      @location = Location.first.nearbys(20)
    end
    @users = @location.collect {|d| d.user}
  end
end
