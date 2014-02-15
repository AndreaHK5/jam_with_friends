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

  private
  
  def find_jam
    sea = params[:id].to_i
    @jam = Jam.find sea
  end

end

