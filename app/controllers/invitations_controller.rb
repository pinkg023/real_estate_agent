class InvitationsController < ApplicationController
  require 'securerandom'
  before_action :authenticate_user!, :only => [:generate]

  def generate
    @secure_number = SecureRandom.hex(8)
    Invitation.create!(invite_token: @secure_number)
    @invite_link = "http://localhost:3000" + "/invitations/" + @secure_number
  end

  def check
    Invitation.where.not(:created_at => 20.seconds.ago..Time.zone.now).destroy_all
    if Invitation.exists?(invite_token: params[:invite_token])
      redirect_to invitations_path
    else
      flash[:alert] = "很抱歉，此非有效邀請，請重新索取。謝謝"
      redirect_to root_path
    end
  end
end
