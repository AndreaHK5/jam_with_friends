class User < ActiveRecord::Base
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
end
