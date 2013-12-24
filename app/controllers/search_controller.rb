class SearchController < ApplicationController
  def index
    if params["search"].empty?
      redrect_to root_path
    else
      safe_params
      instruments_sought
      generes_sought

      location_sought 
      radius_sought
        
      @users = []

      # collects all users in the area
      @locations = Location.near(@location_search, @radius_search)
      # why iterating when you already have the users throug
      @locations.each do |l|
        @instruments_searched.each do |i|
          @generes_searched.each do |g|
            @users << User.search_by_genere(g.id).search_by_instrument(i.id).search_by_location(l.id).first
          end
        end
      end

      #accumulating somethign to then toss it away is not how you were brought up

      @users.compact!

      # cleanup users for duplicates
      @users = @users.uniq
      @users.delete(current_user)

      #the index requires a location to populate the fields (for the time being)
      @location_search


      prepare_hash_for_map
      render 'home/index' 
    end
  end

  private

  def safe_params
   @safe_params = params.require(:search).permit(:location, :radius, :find, :instrument_id => [], :genere_id =>[])
  end

  def instruments_sought
    if @safe_params["instrument_id"].include?("all") || @safe_params["instrument_id"] == nil
      @instruments_searched = Instrument.all
    else
      @ids = @safe_params["instrument_id"]
      @instruments_searched = []
      @ids.each do |instrument_id|
        @instruments_searched << Instrument.search_by_id(instrument_id).first
      end
    end
  end

  def generes_sought
    if @safe_params["genere_id"].include?("all") || @safe_params["genere_id"] == nil
      @generes_searched = Genere.all
    else
      @ids = @safe_params["genere_id"]
      @generes_searched = []
      @ids.each do |genere_id|
        @generes_searched << Genere.search_by_id(genere_id).first
      end
    end
  end

  def update_with_free_search

    if @safe_params[:find] != nil || @safe_params[:find] != ""bass, guitar, rock, jazz""
      params[:find].split(' ').each do |find|

      Instrument.search_by_name(find)
      update_instruments
      Genere.search_by_name(find)
      update_generes
      end
    end 
  end


  def location_sought
    if @safe_params["location"] == nil
      if user_signed_in?
        @location_search = current_user.location.address.to_s
      else
        @location_search = current_location
      end
    else
      @location_search = @safe_params["location"].first.to_s
    end
  end

  def radius_sought
    if @safe_params["radius"] == nil
      @radius_search = "20"
    else
      @radius_search = @safe_params["radius"].first.to_i
    end
  end
end
