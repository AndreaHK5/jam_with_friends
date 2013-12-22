class User < ActiveRecord::Base
  scope :search_by_genere, ->(genere) { joins(:generes).where('generes.id' => genere)}
  scope :search_by_instrument, ->(instrument) { joins(:instruments).where('instruments.id' => instrument)}
  scope :search_by_location, ->(location) { joins(:location).where('locations.id' => location)}
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :iuassociations
  has_many :instruments, through: :iuassociations
  has_many :guassociations
  has_many :generes, through: :guassociations
  has_one :location
  accepts_nested_attributes_for :instruments, :generes
  validates :email, uniqueness: true
  validates :name, uniqueness: true
end
