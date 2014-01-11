class Instrument < ActiveRecord::Base
  has_many :instrxps
  has_many :users, through: :instrxps

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false, message: "instrument already existing" }

  scope :search_by_name, -> (query) {where('name LIKE :query', :query => "%#{query}%")}
end
