class Room < ApplicationRecord
  belongs_to :user
  has_many :reservation

  mount_uploader :hotel, HotelUploader

  validates :name, :introduction, presence: true
  validates :price, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1}
  validates :address, presence: true
end
