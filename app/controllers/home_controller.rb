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
      if current_location == ""
        @location_search = current_location
      end
    end
    @locations = Location.near(@location_search)
    @users = @locations.each.collect {|l| l.user}
    @users.delete(current_user)
    @users = @users.paginate(:page => params[:page], :per_page => 6)
    prepare_hash_for_map
    @instruments_current = []
    @genres_current = []
    if user_signed_in?
      if current_user.instrxps.empty? || current_user.location.nil? || current_user.genres.empty?
        flash[:notice] = "update your profile to become more searcheable, missing"
        current_user.instrxps.empty? ? flash[:notice] << " instruments" : ""
        current_user.genres.empty? ? flash[:notice] << " genres" : ""
        current_user.location.nil? ? flash[:notice] << " location" : ""
      end
    end

    # @users =[User.first]
    # @instruments = [Instrument.first]
    # @genres = [Genre.first]
    # @location_search = "20 crooke ave 11226 ny"
  end
end
