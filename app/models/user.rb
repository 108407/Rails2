class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :rooms
  has_many :reservations
  mount_uploader :avatar, AvatarUploader
  validates :username, :email, presence: true 
  validates :password, :password_confirmation, presence: true, on: :create
end
