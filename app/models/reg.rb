class Reg < ApplicationRecord
  include ActiveModel::Model

  attr_accessor :email, :password, :password_confirmation, :description

  def save
    return false if invalid?

    ActiveRecord::Base.transaction do
      user = User.create!(email: email, password: password, password_confirmation: password_confirmation)
      user.questions.create!(description: description)
    end

    true
  rescue ActiveRecord::StatementInvalid => e
    # Handle exception that caused the transaction to fail
    # e.message and e.cause.message can be helpful
    errors.add(:base, e.message)

    false
  end

end
