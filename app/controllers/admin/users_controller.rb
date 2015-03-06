class Admin::UsersController < ApplicationController

  before_action :check_admin

  def index
    @users = User.all.page(params[:page]).per(3)
  end

  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id]) if params[:id]
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "#{@user.firstname} was created successfully!"
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to admin_user_path(@user), notice: "User information updated succesfully."
    else
      render :edit
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "User has been deleted"
  end

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
      :email, :firstname, :lastname, :admin, :password, :password_confirmation
    )
  end

end

