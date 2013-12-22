class Genere < ActiveRecord::Base
  has_many :guassociations
  has_many :users, through: :guassociations
  
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false, message: "genere already existing" }  

end
