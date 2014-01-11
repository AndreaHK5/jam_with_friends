class Genre < ActiveRecord::Base
  has_many :guassociations
  has_many :users, through: :guassociations
  
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false, message: "genre already existing" }

  scope :search_by_name, -> (query) {where('lower(name) LIKE :query', :query => "%#{query.downcase}%")}
end
