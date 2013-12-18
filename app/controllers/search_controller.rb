class SearchController < ApplicationController
  def index
    if params["search"].empty?
      redrect_to root_path
    else
      instruments_sought
      generes_sought
      location_sought 
      radius_sought

      @users = []


      # collects all users in the area
      @locations = Location.near(@location_search, @radius_search)


      @locations.each do |l|
        @instruments_searched.each do |i|
          @generes_searched.each do |g|
            @users << User.search_by_genere(g.id).search_by_instrument(i.id).search_by_location(l.id).first
          end
        end
      end

      @users.compact!

      # cleanup users for duplicates
      @users = @users.uniq
      @users.delete(current_user)

      #the index requires a location to populate the fields (for the time being)

      if user_signed_in?
        @location = current_user.location
      else
        @location = Location.first
      end

      
      render 'home/index' 
    end
  end

  private

  def instruments_sought
    if params["search"]["instrument_id"].include?("all") || params["search"]["genere_id"] == nil
      @instruments_searched = Instrument.all
    else
      @ids = params["search"]["instrument_id"]
      @instruments_searched = []
      @ids.each do |instrument_id|
        @instruments_searched << Instrument.where(id: instrument_id).first
      end
    end
  end

  def generes_sought
    if params["search"]["genere_id"].include?("all") || params["search"]["genere_id"] == nil
      @generes_searched = Genere.all
    else
      @ids = params["search"]["genere_id"]
      @generes_searched = []
      @ids.each do |genere_id|
        @generes_searched << Genere.where(id: genere_id).first
      end
    end
  end

  def location_sought
    if params["search"]["location"]["address"] == nil
      if user_signed_in?
        @location_search = current_user.location.address.to_s
      else
        @location_search = Location.first.address.to_s
      end
    else
      @location_search = params["search"]["location"]["address"].first.to_s
    end
  end

  def radius_sought
    if params["search"]["location"]["radius"] == nil
      @radius_search = "20"
    else
      @radius_search = params["search"]["location"]["radius"].first.to_i
    end
  end
end
