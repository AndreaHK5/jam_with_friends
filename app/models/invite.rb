class Invite < ActiveRecord::Base
  belongs_to :jam
  belongs_to :user
  belongs_to :instrument

  validates :user, presence: :true
  validates_uniqueness_of :jam_id, :scope => :instrument_id, :message => 'Someone has already been invited', on: :create 
end
