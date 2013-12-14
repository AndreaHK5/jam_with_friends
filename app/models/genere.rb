class Genere < ActiveRecord::Base
  has_many :guassociations
  has_many :users, through: :guassociations  

end
