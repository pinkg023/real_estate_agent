class RegsController < ApplicationController

  def create
    @reg = Reg.new(reg_params)

    if @reg.save
      ContactMailer.say_hello_to(params[:email]).deliver_now
      redirect_to root_url, notice: '註冊完成!'
    else
      render :new
    end
  end

  private
    def reg_params
      params.require(:reg).permit(:email, :password, :password_confirmation, :description, :invite_token)
   end

end
