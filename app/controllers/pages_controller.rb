class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:home]

  def home
    @user = current_user
  end

  def meat_counter
  end

  def choose_category
    @category = Category.all
  end

  def cookbook
    @cookbook = current_user.recipes
  end

  def profile
    @user = current_user
  end
end
