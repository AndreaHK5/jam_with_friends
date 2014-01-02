class Instrxp < ActiveRecord::Base
  belongs_to :user
  belongs_to :instrument

  validates :instrument_id, :uniqueness => {:scope=>:user_id}
  accepts_nested_attributes_for :instrument
end
