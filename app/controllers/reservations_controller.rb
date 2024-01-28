class ReservationsController < ApplicationController
  def index
    @reservations = current_user.reservations
  end

  def create
    @reservation = Reservation.new(reservation_params)
     if @reservation.save
       flash[:notice] = "スケジュールを新規登録しました。"
       redirect_to :reservations
     else
       redirect_to room_path(@reservation.room_id) and return
     end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    flash[:notice] = "予約を削除しました。"
    redirect_to :reservations
  end

  def confirm
    @reservation = Reservation.new(confirm_params)
    @user_id = current_user.id
    @room = Room.find_by(params[:room_id])
 
    if @reservation.check_in == nil || @reservation.check_out == nil || @reservation.number_of_people == nil
      flash.now[:alert_blank] = "予約に失敗しました。未入力の必須項目があります。"
      render "confirm"
    elsif @reservation.check_in < DateTime.now
      flash.now[:alert_check_in] = "予約に失敗しました。チェックインは現在時刻以前に指定できません。"
      render "confirm"
    elsif @reservation.check_out < @reservation.check_in || @reservation.check_in == @reservation.check_out
      flash.now[:alert_day] = "チェックアウトはチェックイン以前に指定できません。"
      render "confirm"
    elsif @reservation.number_of_people < 0 || @reservation.number_of_people == 0
      flash.now[:alert_number] = "人数を0以下にできません。"
      render "confirm"
    else
      @day = (@reservation.check_out - @reservation.check_in).to_i
      @total = @day * @reservation.room.price * @reservation.number_of_people
    end
  end

  def show
    @room = Room.find(params[:id])
  end

  private

  def confirm_params
    params.permit(:check_in, :check_out, :number_of_people, :total_price, :room_id)
  end

  def reservation_params
    params.require(:reservation).permit(:image, :name, :introduction, :total_price, :check_in, :check_out, :room_id, :user_id, :day, :number_of_people)
  end
end
