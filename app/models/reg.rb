class Reg < ApplicationRecord
  include ActiveModel::Model

  attr_accessor :email, :name, :tel, :cel, :password, :password_confirmation, :description, :invite_token

=begin
  def save
    return false if invalid?

    ActiveRecord::Base.transaction do
      @user = User.create!(email: email, password: password, password_confirmation: password_confirmation)
      @user.questions.create!(description: description)
      inviter = User.find_by(invite_token: invite_token)
      #inviter = User.where(:invite_token => invite_token)
      #Invitation.create!(user_id: inviter.id, invited_id: user.id)
      invitation = inviter.invitations.create!(invited_id: @user.id)
    end

    true
  rescue ActiveRecord::StatementInvalid => e
    # Handle exception that caused the transaction to fail
    # e.message and e.cause.message can be helpful
    errors.add(:base, e.message)

    false
  end
=end

end
