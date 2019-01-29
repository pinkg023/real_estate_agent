class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin

  def show
    set_user
    @invited_users = User.joins("INNER JOIN invitations ON invitations.invited_id = users.id").where("user_id = #{@user.id}")  
  end

  def edit
    set_user
  end

  def index
    @users = User.order(created_at: :desc).page(params[:page]).per(20)
  end

  def destroy  
    set_user  
    @user.destroy
    if User.exists?(id: @user.id)
      flash[:alert] = @user.errors.full_messages.to_sentence + @user.title
    else
      flash[:notice] = "用戶已刪除！" 
    end
      redirect_to admin_root_path
  end

  def update
    set_user
      if @user.update(user_params)
        flash[:notice] = "會員資料已更新"    
      else
        render edit_user_path(@user)
        flash[:alert] = @user.errors.full_messages.to_sentence
      end
      redirect_to admin_users_path
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :role, :name, :tel, :cel)
    end
end
