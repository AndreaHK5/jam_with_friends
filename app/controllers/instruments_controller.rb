class InstrumentsController < ApplicationController
  def index
    @instruments = Instrument.all
  end

  def show
    @instrument = Instrument.find params[:id]
  end

  def new
    @instrument = Instrument.new
  end
  
  def create
    @instrument = Instrument.create safe_instrument
    if @instrument.save
      flash[:notice] = "new instrument added!!!"
      redirect_to edit_profile_path(current_user)
    else
      flash[:notice] = "something went wrong with adding #{safe_instrument[:name]}"
      @instrument.save
      @instrument.errors[:name].each do |d| 
        flash[:notice] = flash[:notice] + ", \n #{d}"
      end
      render 'new'
    end
  end

  def edit
    @instrument = Instrument.find params[:id] 
  end
  
  def update 
    @instrument = Instrument.find params[:id]    
    @instrument.update safe_instrument
    if @instrument.save
      flash[:notice] = "instrument edited!!!"
      redirect_to @instrument
    else
      flash[:notice] = "something went wrong"
      render 'edit'
    end
  end

  def destroy
    @instrument = Instrument.find params[:id]
    @instrument.destroy
    flash[:notice] = "#{@instrument.name} has been deleted"
    
    redirect_to instruments_path 
  end

  private

  def safe_instrument
    safe_instrument = params.require(:instrument).permit(:name, :photo)
  end
end
