class Genre < ActiveRecord::Base
  has_many :guassociations
  has_many :users, through: :guassociations
  
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false, message: "genre already existing" }

  scope :search_by_id, -> (query) {where('id LIKE :query', :query => "%#{query}%")}
  scope :search_by_name, -> (query) {where('name LIKE :query', :query => "%#{query}%")}
end
