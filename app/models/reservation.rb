class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room
  validate :date_before_check_out
  def date_before_check_out
    return false if check_in.blank? || check_out.blank?
    if check_out < check_in
    errors.add(:check_out, "は開始日以降のものを選択してください")
    end
  end
end
