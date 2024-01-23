class Room < ApplicationRecord
  belongs_to :user
  has_many :reservation
  mount_uploader :hotel, HotelUploader
  validates :name, :introduction, presence: true
  validates :price, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1}
  validates :address, presence: true
  validate :date_before_check_out
  def date_before_check_out
    return false if check_in.blank? || check_out.blank?
    if check_out < check_in
    errors.add(:check_out, "は開始日以降のものを選択してください")
    end
  end
  def self.search(search)
    return Item.all unless search
    Item.where('name LIKE(?)', "%#{search}%")
  end
end
