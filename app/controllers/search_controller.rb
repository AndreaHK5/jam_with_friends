class SearchController < ApplicationController
  def index
    if params["search"].empty?
      redrect_to root_path
    else
      instruments_sought
      geners_sought
      location_sought 
      radius_sought

      @users_in_area = []
      # location filer collects all users in the area
      @location_search.nearbys(@radius_search).each do |location|
        @users_in_area << location.user
      end

      @users = []
      
      #collect users for an instrument 
      @users_in_area.each do |user|
        @instruments_searched do |instrument|
          if user.instruments.include?(instrument)
            @user << user
          end
        end
      end
      
      #collect users for a genere 
      @users_in_area.each do |user|
        @generes_searched do |genere|
          if user.generes.include?(genere)
            @user << user
          end
        end
      end
      # cleanup users for duplicates
      @user = @user.uniq

      render 'home/index' 
    end
  end

  private

  def instruments_sought
    if params["search"]["instrument_id"].include?("all") || params["search"]["generes_id"] == nil
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
    if params["search"]["generes_id"].include?("all") || params["search"]["generes_id"] == nil
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
        @location_search = current_user.location
      else
        @location_search = Location.first
      end
    else
      @location_search = params["search"]["location"]["address"]
    end
  end

  def radius_sought
    if params["search"]["location"]["radius"] == nil
      @radius_search = "20"
    else
      @radius_search = params["search"]["location"]["radius"]
    end
  end



end
