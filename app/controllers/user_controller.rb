class UserController < ApplicationController
  def update
    @user.update(user_params)
    redirect_to root_path(@user.id)
  end

  def destroy
    @user.destroy
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :birthday, :gender, :password, :photo)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
