class SearchController < ApplicationController
  def index
    if params["search"].empty?
      redrect_to root_path
    else
      safe_params
      # this shoudl not happen here, i shoudl search, if the search is empty BUT @instruments or @genres are there do not re initialise

      @instruments = []
      @genres = []
      
      if @safe_params[:find] != nil
        update_with_free_search
      end
      
      instruments_sought
      genres_sought
      
      location_sought 
      radius_sought

      if @instruments.empty?
        @instruments = Instrument.all
      end
      
      if @genres.empty?
        @genres = Genre.all
      end

      @users = []
      options = {
        location: @location_search,
        user: current_user,
        instruments: @instruments,
        genres: @genres,
        radius: @radius_search
      }
      @users = UserLocator.call(options)
      
      @users = @users.paginate(:page => params[:page], :per_page => 6)
      prepare_hash_for_map
      @instruments_current = @instruments.collect {|i| i.id}
      @genres_current = @genres.collect {|g| g.id}
      render 'home/index' 
    end
  end

  private

  def safe_params
   @safe_params = params.require(:search).permit(:location, :radius, :find, :instrument_id => [], :genre_id =>[])
  end

  def instruments_sought
    if @safe_params["instrument_id"] == nil
      if @instruments.empty?
        @instruments = Instrument.all
      end
    else
      if @safe_params["instrument_id"].include?("all")
        @instruments = Instrument.all
      else
        @ids = @safe_params["instrument_id"]
        @instruments = []
        @ids.each do |instrument_id|
          @instruments << Instrument.find_by_id(instrument_id.to_i)
        end
      end
    end
  end

  def genres_sought
    if @safe_params["genre_id"] == nil
      if @genres.empty?
      @genres = Genre.all
    end
    else
      if @safe_params["genre_id"].include?("all")
        @genres = Genre.all
      else
        @ids = @safe_params["genre_id"]
        @genres = []
        @ids.each do |genre_id|
          @genres << Genre.find_by_id(instrument_id.to_i)
        end
      end
    end
  end

  def update_with_free_search
    if !@safe_params[:find].empty?
      @safe_params[:find].split(' ').each do |find|
      instrument = Instrument.search_by_name(find)
      if !instrument.empty?
      @instruments << instrument.first
      end
      @instruments.uniq
      genre = Genre.search_by_name(find)
      if !genre.empty?
      @genres << genre.first
      end
      @genres.uniq
      # would be cool to search as well if the search params has alreay inside the insuments and genres, in order to prevent calling uniq
      # also, would be cool to skip the genres search in case the instrument search is positive (something is either an instrument or a genre)
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
