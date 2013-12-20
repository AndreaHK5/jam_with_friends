class ProfileController < ApplicationController
  before_filter :autenticate_user!, except: [:show]

  def new
    @instruments = Instrument.all
    @generes = Genere.all
    @user = current_user
    @user.location = Location.new
  end
  
  def show
    @user = User.find params[:id]
  end


  def edit
    @instruments = Instrument.all
    @generes = Genere.all
    @user = current_user
    if @user.location == nil
      @user.location = Location.first
    end
  end

  def update
    if params["user"].empty?  
      flash[:message] = "no instruments or genere it is then" 
      current_user.instruments = []
      current_user.generess = []
    else
      if params["user"]["instrument_id"].empty?
        current_user.instruments = []
      else      
        @ids = params["user"]["instrument_id"]
        current_user.instruments = []
        @ids.each do |instrument_id|
        current_user.instruments << Instrument.where(id: instrument_id)
        end
      end

      if params["user"]["genere_id"].empty?
        current_user.generes = []
      else
        @ids = params["user"]["genere_id"]
        current_user.generes = []
        @ids.each do |genere_id|
         current_user.generes << Genere.where(id: genere_id)
        end
      end

      if params["user"]["location"].empty?
        current_user.location.address = ""
      else
        current_user.location.address = params["user"]["location"]
        current_user.location.radius = params["user"]["radius"]
        current_user.location.save
      end
    end
    redirect_to profile_path(current_user)
  end
end
