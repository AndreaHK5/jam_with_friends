class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
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
