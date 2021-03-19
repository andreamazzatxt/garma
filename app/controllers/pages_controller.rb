class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @disable_nav = true
    @disable_avatar = true
    @example = Product.first
  end

  def profile
  end
end
