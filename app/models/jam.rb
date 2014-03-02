class Jam < ActiveRecord::Base
  belongs_to :location
  belongs_to :user


  has_many :candidates
  has_many :candidate_instruments, through: :candidates, :source => :instrument
  has_many :candidate_users, through: :candidates, :source => :user

  has_many :invites
  has_many :invited_instruments, through: :invites, :source => :instrument
  has_many :invited_users, through: :invites, :source => :user

  accepts_nested_attributes_for :invites, :candidates
  scope :search_by_instrument, ->(query) { includes(:candidate_instruments).where({ instruments: { id: query}})}
end
