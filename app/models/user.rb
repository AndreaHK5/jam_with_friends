class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  acts_as_messageable
  has_many :instrxps
  has_many :instruments, through: :instrxps
  has_many :guassociations
  has_many :genres, through: :guassociations
  has_one :location
  accepts_nested_attributes_for :instruments, :genres
  validates :email, uniqueness: true
  validates :name, uniqueness: true
  accepts_nested_attributes_for :instrxps
  accepts_nested_attributes_for :instruments

  has_attached_file :photo

  has_many :candidates
  has_many :candidate_instruments, through: :candidates, :source => :instrument
  has_many :candidate_jams, through: :candidates, :source => :jam

  has_many :invites
  has_many :invited_instruments, through: :invites, :source => :instrument
  has_many :invited_jams, through: :invites, :source => :jam  



  def mail_email(object)
    email
  end



  def mailboxer_email(object)
  #Check if an email should be sent for that object
  #if true
  return :email
  #if false
  # return nil
end


# first version WORS, without string sanitation!
  # scope :search_by_genre, ->(genre) { joins(:genres).where('genres.id' => genre)}
  # scope :search_by_instrument, ->(instrument) { joins(:instruments).where('instruments.id' => instrument)}
  # scope :search_by_location, ->(location) { joins(:location).where('locations.id' => location)}

#second version - WORKS! - with string sanitization
  # def self.search_by_genre(query)
  #   joins(:genres).where('genres.id LIKE :query', :query  => "%#{query}%")
  # end
  # def self.search_by_genre(query)
  #   joins(:genres).where('genres.id' => genre)
  # end

  # def self.search_by_instrument(query)
  #   joins(:instruments).where('instruments.id LIKE :query', :query  => "%#{query}%")
  # end

  # def self.search_by_location(query)
  #   joins(:location).where('locations.id LIKE :query', :query  => "%#{query}%")
  # end

# third version - all rolled together
  # scope :search_by_genre, ->(query) { joins(:genres).where('genres.id LIKE :query', :query => "#{query}")}
  scope :search_by_genre, ->(query)     { includes(:genres).where({ genres: { id: query}})}
  scope :search_by_instrument, ->(query) { includes(:instruments).where({ instruments: { id: query}})}
end
