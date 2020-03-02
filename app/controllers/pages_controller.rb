class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @user = current_user
  end

  def cookbook
    @cookbook = current_user.recipes
  end

  def profile
    @user = current_user
  end
end
