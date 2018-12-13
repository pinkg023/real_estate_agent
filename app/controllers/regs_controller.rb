class RegsController < ApplicationController

  def create
    @reg = Reg.new(reg_params)

    @user = User.new(email: reg_params[:email], password: reg_params[:password], password_confirmation: reg_params[:password_confirmation])
      if @user.save
        @user.questions.create!(description: reg_params[:description])
        inviter = User.find_by(invite_token: reg_params[:invite_token])
        invitation = inviter.invitations.create!(invited_id: @user.id)
        #ContactMailer.say_hello_to(reg_params[:email]).deliver_now
        sign_in( @user , scope: :user)
        flash[:notice] = '註冊完成!'
      else
        flash[:alert] = @user.errors.full_messages.to_sentence
      end
        redirect_to root_path
=begin
    if @reg.save
      ContactMailer.say_hello_to(params[:email]).deliver_now
      sign_in( User.last , scope: :user)
      redirect_to root_url, notice: '註冊完成!'
    else
      render :new
    end
=end
  end

  private
    def reg_params
      params.require(:reg).permit(:email, :password, :password_confirmation, :description, :invite_token)
   end

end
