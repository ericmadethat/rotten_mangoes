class Admin::UsersController < ApplicationController

  before_action :check_admin

  protected

  def check_admin
    unless current_user && current_user.admin then
      flash[:notice] = "Must be admin"
      redirect_to new_session_path
    else
      @admin_user = current_user
    end
  end

  def user_params
    params.require(:user).permit(
      :email, :firstname, :lastname, :admin
    )
  end

end

