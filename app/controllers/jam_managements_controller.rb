class JamManagementsController < ApplicationController
  def show
    find_jam
    @jam_participants = {}
    @jam.candidates.each do |c|
      unless @jam_participants.keys.include?(:"#{c.instrument.name}")
        @jam_participants.merge!(:"#{c.instrument.name}" => {:candidates => []})
      end
    @jam_participants[:"#{c.instrument.name}"][:candidates] << c.user 
    end

    @jam.invites.each do |c|
      unless @jam_participants.keys.include?(:"#{c.instrument.name}")
        @jam_participants.merge!(:"#{c.instrument.name}" => {:invites => []})
      else
        @jam_participants[:"#{c.instrument.name}"].merge!(:invites => [])
      end  
    @jam_participants[:"#{c.instrument.name}"][:invites] << c.user 
    end
  end

  def edit_candidates
    @jam = Jam.find(params[:jam_id].to_i)
    @instrument = Instrument.search_by_name(params[:instrument_name]).first
    @candidates = Candidate.where(jam_id: @jam.id, instrument_id: @instrument.id)
  end

  def update_candidates
    @jam = Jam.find(params[:jam_id].to_i)
    @instrument = Instrument.find(params[:instrument_id].to_i)
    @prev_candidates = Candidate.where(jam_id: @jam.id, instrument_id: @instrument.id)
    @prev_candidates.each {|c| c.delete}
    # delete the candidates for 
    params[:users][:id].each do |id|
      unless id == ""
        Candidate.create(user_id: id.to_i, jam_id: @jam.id, instrument_id: @instrument.id)
      end
    end
    redirect_to :action => :show, :jam_id => @jam.id
  end

  private
  
  def find_jam
    sea = params[:jam_id].to_i
    @jam = Jam.find sea
  end

end

