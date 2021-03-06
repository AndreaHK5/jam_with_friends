class ProfileController < ApplicationController
  before_filter :authenticate_user!, except: [:show]
  before_filter :check_user,  :only => [:edit, :update]

  def new
    @instruments = Instrument.all
    @genres = Genre.all
    @user = current_user
    @user.location = Location.new
  end
  
  def show
    @user = User.find params[:id]
    if @user == current_user
      render 'show_own'
    else
      render 'show'
    end
  end


  def edit
    @instruments = Instrument.all
    @genres = Genre.all
    if @user.location == nil
      @user.location = Location.first
    end
    3.times {current_user.instrxps.build } 
  end

  def update
   safe_params
    if @safe_params[:instrxps] == nil
      current_user.instrxps.each {|i| i.destroy}
      flash[:notice] = flash[:notice].to_s + " \n no instruments =("
    else
      current_user.instrxps.each {|i| i.destroy}
      @safe_params[:instrxps].each do |andrea|
        if !andrea[:instrument_id].empty?
          Instrxp.create(user_id: current_user.id, instrument_id: andrea[:instrument_id].to_i, since: andrea[:since].to_i)
        end
      end
    end

    if @safe_params[:genres_id] == nil
      current_user.genres = []
      flash[:notice] = flash[:notice].to_s + " \n no genres =("
    else
      @ids = @safe_params[:genres_id]
      current_user.genres = []
      @ids.each do |genre_id|
       current_user.genres << Genre.find_by_id(genre_id.to_i)
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

    unless @safe_params[:photo].nil?
      current_user.photo = @safe_params[:photo]
      current_user.save
    end

    redirect_to profile_path(current_user)
  end

  private

    def safe_params
     @safe_params = params.require(:user).permit(:location, :radius, :photo, instrxps: [:instrument_id,:since], :genres_id =>[])
   end

  def check_user
    @user = User.find(params[:id])
    if current_user != @user        
      redirect_to root_url, :notice => "Cannot act on different user."
    end
  end

  # def selected_instrument(i)
 
  #    i.instrument.empty?
  #   i.instrument.id 
  # end
  
end
