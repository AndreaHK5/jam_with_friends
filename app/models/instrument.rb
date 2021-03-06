class Instrument < ActiveRecord::Base
  has_many :instrxps
  has_many :users, through: :instrxps

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false, message: "instrument already existing" }

  has_attached_file :photo, :styles => {:mapmarker => "40x40>"}

  scope :search_by_name, -> (query) {where('lower(name) LIKE :query', :query => "%#{query.downcase}%")}
end
