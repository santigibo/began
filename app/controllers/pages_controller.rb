class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:home]

  def home
    @user = current_user
  end

  def meat_counter

  end

  def add_one
    current_user.update(no_meat_counter: current_user.no_meat_counter += 1)
    @count = current_user.no_meat_counter
    respond_to do |format|
      format.html { no_meat_counter_path }
      format.js  # <-- will render `app/views/reviews/create.js.erb`
    end
  end

  def choose_cookbook
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
