class UsersController < ApplicationController
  def account
    @user = current_user
  end

  def profile
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(params_profile)
      flash[:notice_chabge_profile] = "プロフィール情報を更新しました"
      redirect_to '/users/profile'
    else
      render "edit"
    end
  end


  private

  def params_profile
    params.require(:user).permit(:userimage, :username, :userintroduction, :avatar)
  end
end
