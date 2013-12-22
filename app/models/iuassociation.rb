class Iuassociation < ActiveRecord::Base
  belongs_to :user
  belongs_to :instrument

  validates :instrument_id, :uniqueness => {:scope=>:user_id}
end
