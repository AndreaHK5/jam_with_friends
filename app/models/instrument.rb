class Instrument < ActiveRecord::Base
  has_many :instrexps
  has_many :users, through: :instrexps

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false, message: "instrument already existing" }

  scope :search_by_id, -> (query) {where('id LIKE :query', :query => "%#{query}%")}
  scope :search_by_name, -> (query) {where('name LIKE :query', :query => "%#{query}%")}
end
