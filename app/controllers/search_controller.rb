class SearchController < ApplicationController
  def index
    if params["search"].empty?
      redrect_to root_path
    else
      safe_params
      # this shoudl not happen here, i shoudl search, if the search is empty BUT @instruments or @generes are there do not re initialise

      @instruments = []
      @generes = []
      
      if @safe_params[:find] != nil
        update_with_free_search
      end
      
      instruments_sought
      generes_sought
      
      location_sought 
      radius_sought

      if @instruments.empty?
        @instruments = Instrument.all
      end
      
      if @generes.empty?
        @generes = Genere.all
      end

      @users = []
      @locations = Location.near(@location_search, @radius_search)
      @instruments.each do |i|
        @generes.each do |g|
          @user_matching = User.search_by_genere(g.id).search_by_instrument(i.id)
          @locations.each do |l|
            if @user_matching.to_a.include?(l.user)
              @users << l.user
            end
          end
        end
      end

      @users.compact!
      @users = @users.uniq
      @users.delete(current_user)

      prepare_hash_for_map
      @instruments_current = @instruments.collect {|i| i.id}
      @generes_current = @generes.collect {|g| g.id}
      render 'home/index' 
    end
  end

  private

  def safe_params
   @safe_params = params.require(:search).permit(:location, :radius, :find, :instrument_id => [], :genere_id =>[])
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
          @instruments << Instrument.search_by_id(instrument_id).first
        end
      end
    end
  end

  def generes_sought
    if @safe_params["genere_id"] == nil
      if @generes.empty?
      @generes = Genere.all
    end
    else
      if @safe_params["genere_id"].include?("all")
        @generes = Genere.all
      else
        @ids = @safe_params["genere_id"]
        @generes = []
        @ids.each do |genere_id|
          @generes << Genere.search_by_id(genere_id).first
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
      genere = Genere.search_by_name(find)
      if !genere.empty?
      @generes << genere.first
      end
      @generes.uniq
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
