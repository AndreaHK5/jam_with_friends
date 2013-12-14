class Instrument < ActiveRecord::Base
  has_many :iuassociations
  has_many :users, through: :iuassociations
end
