class ProfileController < ApplicationController
  before_filter :authenticate_user!, except: [:show]
  before_filter :check_user,  :only => [:edit, :update]

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
   safe_params
    if @safe_params[:instrument_id] == nil
      current_user.instruments = []
      flash[:notice] = flash[:notice].to_s + " \n no instruments =("
    else      
      @ids = @safe_params[:instrument_id]
      current_user.instruments = []
      @ids.each do |instrument_id|
      current_user.instruments << Instrument.search_by_id(instrument_id)
      end
    end

    if @safe_params[:genere_id] == nil
      current_user.generes = []
      flash[:notice] = flash[:notice].to_s + " \n no generes =("
    else
      @ids = @safe_params[:genere_id]
      current_user.generes = []
      @ids.each do |genere_id|
       current_user.generes << Genere.search_by_id(genere_id)
      end
    end

    if @safe_params[:location].empty?
      current_user.location.address = ""
      current_user.location.save
    else
      current_user.location.address = @safe_params[:location]
      current_user.location.save
    end


    if @safe_params[:radius].empty?
      current_user.location.radius = 0
      current_user.location.save
    else
      current_user.location.radius = @safe_params[:radius]
      current_user.location.save
    end

    redirect_to profile_path(current_user)
  end

  private

    def safe_params
     @safe_params = params.require(:user).permit(:location, :radius, :instrument_id => [], :genere_id =>[])
   end

  def check_user
    @user = User.find(params[:id])
    if current_user != @user        
      redirect_to root_url, :notice => "Cannot act on different user."
    end
  end
  
end
