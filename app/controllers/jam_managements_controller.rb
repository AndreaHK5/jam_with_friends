class JamManagementsController < ApplicationController
  before_filter :authenticate_user!
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
    find_jam
    find_instrument_by_name
    fill_candidates
  end

  def update_candidates
    find_jam
    find_instrument
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

  def edit_invite
    find_jam
    find_instrument_by_name
    fill_candidates
    @invite = Invite.where(jam_id: @jam.id, instrument_id: @instrument.id).first
  end

  def update_invite
    find_jam
    find_instrument
    @prev_invited = Invite.find_by(jam_id: @jam.id, instrument_id: @instrument.id)
    @current_invited = User.find(params[:users][:id].to_i)
    if @prev_invited.nil?
      Invite.create(jam_id: @jam.id, instrument_id: @instrument.id, user_id:  @current_invited.id)
    else
      if @prev_invited.user.id.to_i != @current_invited.id
        Invite.find_by(jam_id: @jam.id, instrument_id: @instrument.id, user_id: @prev_invited.id).delete
        Invite.create(jam_id: @jam.id, instrument_id: @instrument.id, user_id: @current_invited.id)
      end
    end
    redirect_to :action => :show, :jam_id => @jam.id
  end

  def candidate
    find_jam
    find_instrument
    Candidate.create(user_id: current_user.id, jam_id: @jam.id, instrument_id: @instrument.id)   
    redirect_to jam_path(@jam)
  end

  def withdraw_candidate
    find_jam
    find_instrument
    c = Candidate.where(user_id: current_user.id, jam_id: @jam, instrument_id: @instrument.id).first
    c.user = nil
    c.save
    redirect_to jam_path(@jam)
  end

  def refuse_invite
    find_jam
    find_instrument
    binding.pry
    Invite.where(user_id: current_user.id, jam_id: @jam, instrument_id: @instrument.id).first.destroy
    redirect_to jam_path(@jam)
  end

  private
  
  def find_jam
    sea = params[:jam_id].to_i
    @jam = Jam.find sea
  end

  def find_instrument
    @instrument = Instrument.find(params[:instrument_id].to_i)
  end

  def find_instrument_by_name
    @instrument = Instrument.search_by_name(params[:instrument_name]).first
  end

  def fill_candidates
    @candidates = Candidate.where(jam_id: @jam.id, instrument_id: @instrument.id)
    @candidates = @candidates.reject {|c| c.user.nil?}
  end

end

