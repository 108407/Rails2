class AddHotelToRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :hotel, :string
  end
end
