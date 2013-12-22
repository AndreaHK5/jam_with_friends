class Guassociation < ActiveRecord::Base
  belongs_to :user
  belongs_to :genere

  validates :genere_id, :uniqueness => {:scope=>:user_id}

end
