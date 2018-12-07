class RegsController < ApplicationController

  def create
    @reg = Reg.new(reg_params)

    if @reg.save
      redirect_to root_url, notice: 'Registration successful!'
    else
      render :new
    end
  end

  private
    def reg_params
      params.require(:reg).permit(:email, :password, :password_confirmation, :description)
   end

end
