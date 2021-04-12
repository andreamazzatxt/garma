class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:api_garderobe, :api_karma, :api_info, :api_update]
  def update
    @user.update(user_params)
    redirect_to profile_path(@user.id)
  end

  def edit
    @user = User.find(params[:id])
    redirect_to edit_user_registration_path(@user.id)
  end

  def destroy
    @user.destroy
    redirect_to root_path
  end

  def api_info
    if current_user
      render json: parse_user(current_user)
    else
      render json: { error: 'User not logged in' }, status: 401
    end
  end

  def api_update
    allowed = {}
    allowed[:first_name] = params[:first_name] if params[:first_name]
    allowed[:last_name] = params[:last_name] if params[:last_name]
    allowed[:gender] = params[:gender] if params[:gender]
    allowed[:birthday] = params[:birthday] if params[:birthday]
    if current_user
      current_user.update(allowed)
      render json: current_user
    else
      render json: { error: 'User not logged in' }, status: 401
    end
  end

  def api_garderobe
    if current_user
      render json: current_user.products_hash
    else
      render json: ['User not logged in'], status: 401
    end
  end

  def api_karma
    if current_user
      render json: { karma: current_user.karma}
    else
      render json: { karma: nil, error: 'User not logged in'}, status: 401
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :birthday, :gender, :password, :photo)
  end

  def find_user
    @user = User.find(params[:id])
  end

  def parse_user(user)
    {
      name: {
        first: user.first_name,
        last: user.last_name,
      },
      gender: user.gender,
      birthday: user.birthday,
      photo: user.photo.url
    }
  end
end
