class JamsController < ApplicationController
    before_filter :authenticate_user!, except: [:show, :index]

  def index
    @jams = Jam.all
  end

  def new
    @jam = Jam.new
    5.times {@jam.candidates.build}  
  end

  def create
    safe_params
    @jam = Jam.new
    instruments_required
    @jam.save
    if !@jam.errors.messages.empty?
      @errors = @jam.errors
      render 'jam_not_edited'
    else
      redirect_to @jam
    end
  end

  def show
    find_jam
  end

private
  def find_jam
    sea = params[:id].to_i
    @jam = Jam.find sea
  end

  
  def safe_params
    @safe_params = params.require(:jam).permit(:location, :date, candidate: [:instrument_id])
  end

  def instruments_required
    @safe_params[:candidate].uniq.each do |i_id|
        unless i_id[:instrument_id].to_i == 0
          @jam.candidate_instruments << Instrument.find(i_id[:instrument_id].to_i)
        end
    end
  end


end
