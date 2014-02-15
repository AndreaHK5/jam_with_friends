class JamsController < ApplicationController
    before_filter :authenticate_user!, except: [:show, :index]

  def index
    @jams = Jam.all
  end

  def new
    @jam = Jam.new 
  end

  def create
    safe_params
    @jam = Jam.new
    instruments_required
    basic_jam
  end

  def show
    find_jam
  end

  def edit
    find_jam
  end

  def update
    safe_params
    find_jam
    basic_jam
  end

private

  def find_jam
    sea = params[:id].to_i
    @jam = Jam.find sea
  end
  
  def safe_params
    @safe_params = params.require(:jam).permit(:location, :date, candidate_instruments: [])
  end

  def basic_jam
    instruments_required
    @jam.date = @safe_params[:date]
    @jam.location = Location.create :address => @safe_params[:location]
    @jam.user = current_user
    @jam.save
    if !@jam.errors.messages.empty?
      @errors = @jam.errors
      render 'jam_not_created'
    else
      redirect_to @jam
    end
  end

  def instruments_required
    @safe_params[:candidate_instruments].uniq.each do |i_id|
        unless i_id.empty?
        instrument = Instrument.find(i_id.to_i)  
          unless @jam.candidate_instruments.to_a.include?(instrument)
            @jam.candidate_instruments << instrument
          end
        end
    end
  end


end
