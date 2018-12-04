class UsersController < ApplicationController
  before_action :set_user, :only => [:show, :edit, :update, :followings, :followers, :likes ]
  before_action :check_userself, :only => [:show, :edit, :update]


  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :role, :name, :tel, :cel)
    end

    def check_userself
      if current_user!=@user
      redirect_to user_path
      flash[:alert] = "權限不足！"
      end
  end
end
