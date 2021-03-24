class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :profile, :about]

  def home
    @disable_nav = true
    @disable_avatar = true
    @example = Product.first
  end

  def profile
    @disable_avatar = true
  end

  def about; end
end
