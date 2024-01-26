class RoomsController < ApplicationController
  
  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    
    if @room.save
      flash[:notice] = "施設が作成されました。"
      redirect_to '/rooms/own'
    else
      render "new"
    end
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
     if @room.update(room_params)
       flash[:notice] = "施設情報を更新しました。"
       redirect_to '/rooms/own'
     else
       flash.now[:notice] = "施設情報を更新できませんでした。"
       render "edit"
     end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    flash[:notice] = "施設情報を削除しました。"
    redirect_to '/rooms/own'
  end

  #ユーザーごとに作成した部屋を表示するためのアクション
  def own
    @rooms = Room.all
  end

  #検索アクション
  def search
    if !params[:search_keyword].present? || params[:search_area].present?
      @rooms = Room.where('address LIKE(?)', "%#{params[:search_area]}%")
    elsif params[:search_keyword].present?
      @rooms = Room.where('name LIKE(?) OR introduction LIKE(?)', "%#{params[:search_keyword]}%", "%#{params[:search_keyword]}%")
    else
      @rooms = Room.all
    end
  end

  def show
    @room = Room.find(params[:id])
  end

  private

  def room_params
    params.require(:room).permit(:name, :introduction, :image, :price, :address, :hotel).merge(user_id: current_user.id)
  end
end
