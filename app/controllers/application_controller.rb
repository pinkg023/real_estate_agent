class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #before_action :authenticate_user!
  #before_action :configure_permitted_parameters, if: :devise_controller?

  def authenticate_admin
    unless current_user.role != "admin"
      flash[:alert] = "權限不足!"
      redirect_to root_path
    end
  end
end
