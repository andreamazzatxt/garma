class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :profile]

  def home
    @disable_nav = true
    @example = Product.first
  end

  def profile
  end
end

