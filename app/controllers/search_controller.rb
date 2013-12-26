class SearchController < ApplicationController
  def index
    if params["search"].empty?
      redrect_to root_path
    else
      safe_params
      @instruments_searched = []
      @generes_searched = []
      instruments_sought
      generes_sought
      location_sought 
      radius_sought
      update_with_free_search
      if @instruments_searched.empty?
        @instruments_searched = Instrument.all
      end
      if @generes_searched.empty?
        @generes_searched = Genere.all
      end
      @users = []
      # collects all users in the area
      @locations = Location.near(@location_search, @radius_search)
      # why iterating when you already have the users throug
      @instruments_searched.each do |i|
        @generes_searched.each do |g|
          @user_matching = User.search_by_genere(g.id).search_by_instrument(i.id)
          @locations.each do |l|
            if @user_matching.to_a.include?(l.user)
              @users << l.user
            end
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
    unless @safe_params["instrument_id"] == nil
      if @safe_params["instrument_id"].include?("all")
        @instruments_searched = Instrument.all
      else
        @ids = @safe_params["instrument_id"]
        @instruments_searched = []
        @ids.each do |instrument_id|
          @instruments_searched << Instrument.search_by_id(instrument_id).first
        end
      end
    end
  end

  def generes_sought
    unless  @safe_params["genere_id"] == nil
      if @safe_params["genere_id"].include?("all")
        @generes_searched = Genere.all
      else
        @ids = @safe_params["genere_id"]
        @generes_searched = []
        @ids.each do |genere_id|
          @generes_searched << Genere.search_by_id(genere_id).first
        end
      end
    end
  end

  def update_with_free_search

    if !@safe_params[:find].empty?
      @safe_params[:find].split(' ').each do |find|
      instrument = Instrument.search_by_name(find)
      if !instrument.empty?
      @instruments_searched << instrument.first
      end
      @instruments_searched.uniq
      genere = Genere.search_by_name(find)
      if !genere.empty?
      @generes_searched << genere.first
      end
      @generes_searched.uniq
      # would be cool to search as well if the search params has alreay inside the insuments and generes, in order to prevent calling uniq
      # also, would be cool to skip the generes search in case the instrument search is positive (something is either an instrument or a genere)
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
      @location_search = @safe_params["location"]
    end
  end

  def radius_sought
    if @safe_params["radius"] == nil
      @radius_search = "20"
    else
      @radius_search = @safe_params["radius"]
    end
  end
end
