class Genere < ActiveRecord::Base
  has_many :guassociations
  has_many :users, through: :guassociations
  
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false, message: "genere already existing" }

  scope :search_by_id, -> (query) {where('id LIKE :query', :query => "%#{query}%")}
end
