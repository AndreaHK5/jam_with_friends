class HomeController < ApplicationController
  def index
    if user_signed_in?
      @location = current_user.location
    else
      @location = Location.first
    end
  end
end
