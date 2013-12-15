class SearchController < ApplicationController
  def index
    if params["search"].empty?
      redrect_to root_path
    else
      @users = []
      if params["search"]["instrument_id"] == nil
        @instruments = Instrument.all
      else
        @ids = params["search"]["instrument_id"]
        @ids.each do |instrument_id|
          Instrument.where(id: instrument_id).first.users.each do |user|
          @users << user
          end
        end   
      end
      if params["search"]["genere_id"] == nil
        @generes = Genere.all
      else
        @ids = params["search"]["genere_id"]
        @ids.each do |genere_id|
          Genere.where(id: genere_id).first.users.each do |user|
          @users << user
          end
        end 
      end
      render 'home/index' 
    end
  end
end
