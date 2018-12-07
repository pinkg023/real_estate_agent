class InvitationsController < ApplicationController
  require 'securerandom'
  before_action :authenticate_user!, :only => [:generate]

  def generate
    @secure_number = SecureRandom.hex(8)
    Invitation.create!(invite_token: @secure_number)
    @invite_link = "http://localhost:3000" + "/invitations/" + @secure_number
  end

  def check
    Invitation.where.not(:created_at => 30.days.ago..Time.zone.now).destroy_all
    if Invitation.exists?(invite_token: params[:invite_token])
      @reg = Reg.new
    else
      flash[:alert] = "很抱歉，此非有效邀請，請重新索取。謝謝"
      redirect_to root_path
    end
  end

  private
    def invited_user_params
      params.require(:user).permit(:email, :password, :password_confirmation,:role, :name, :tel, :cel, question_attributes: [:id, :user_id, :description])
   end
end
