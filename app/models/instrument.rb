class Instrument < ActiveRecord::Base
  has_many :iuassociations
  has_many :users, through: :iuassociations

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false, message: "instrument already existing" }

  scope :search_by_id, -> (query) {where('id LIKE :query', :query => "%#{query}%")}
end
