class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :instrxps
  has_many :instruments, through: :instrxps
  has_many :guassociations
  has_many :generes, through: :guassociations
  has_one :location
  accepts_nested_attributes_for :instruments, :generes
  validates :email, uniqueness: true
  validates :name, uniqueness: true
  accepts_nested_attributes_for :instrxps
  accepts_nested_attributes_for :instruments

# first version WORS, without string sanitation!
  # scope :search_by_genere, ->(genere) { joins(:generes).where('generes.id' => genere)}
  # scope :search_by_instrument, ->(instrument) { joins(:instruments).where('instruments.id' => instrument)}
  # scope :search_by_location, ->(location) { joins(:location).where('locations.id' => location)}

#second version - WORKS! - with string sanitization
  # def self.search_by_genere(query)
  #   joins(:generes).where('generes.id LIKE :query', :query  => "%#{query}%")
  # end
  # def self.search_by_genere(query)
  #   joins(:generes).where('generes.id' => genere)
  # end

  # def self.search_by_instrument(query)
  #   joins(:instruments).where('instruments.id LIKE :query', :query  => "%#{query}%")
  # end

  # def self.search_by_location(query)
  #   joins(:location).where('locations.id LIKE :query', :query  => "%#{query}%")
  # end

# third version - all rolled together
  scope :search_by_genere, ->(query) { joins(:generes).where('generes.id LIKE :query', :query => "#{query}")}
  scope :search_by_instrument, ->(query) { joins(:instruments).where('instruments.id LIKE :query', :query => "#{query}")}
  scope :search_by_location, ->(query) { joins(:location).where('locations.id LIKE :query', :query => "#{query}")}

end
