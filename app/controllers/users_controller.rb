class UsersController < ApplicationController
  before_action :set_user, :only => [:show, :edit, :coupon ]
  before_action :check_userself, :only => [:show, :edit]

  def update
    set_user
    if @user == current_user
      if @user.update(user_params)
        flash[:notice] = "個人資料已更新"
        redirect_to user_path(@user)      
      else
        render edit_user_path(@user)
        flash[:alert] = @user.errors.full_messages.to_sentence
      end
    else 
      flash[:alert] = "權限不足！"
      redirect_to root_path
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :role, :name, :tel, :cel)
    end

    def check_userself
      if current_user!=@user
      redirect_to root_path
      flash[:alert] = "權限不足！"
      end
  end
end