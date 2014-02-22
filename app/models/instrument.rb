class Instrument < ActiveRecord::Base
  has_many :instrxps
  has_many :users, through: :instrxps

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false, message: "instrument already existing" }

  has_many :candidates
  has_many :candidate_jams, through: :candidates, :source => :jam
  has_many :candidate_users, through: :candidates, :source => :user

  has_many :invites
  has_many :invited_users, through: :invites, :source => :user
  has_many :invited_jams, through: :invites, :source => :jam

  has_attached_file :photo, :styles => {:mapmarker => "40x40>"}

  scope :search_by_name, -> (query) {where('lower(name) LIKE :query', :query => "%#{query.downcase}%")}

  def picture_from_url(url)
    self.picture = open(url)
  end
end
