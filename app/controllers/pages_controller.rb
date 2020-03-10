class PagesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:landingpage]

  def landingpage
  end

  def home
    @user = current_user
  end

  def meat_counter
    @no_meat_days = NoMeatDay.all.select { |nmd| nmd.user == current_user }
  end

  def add_one
    current_user.update(no_meat_counter: current_user.no_meat_counter += 1)
    NoMeatDay.create(user: current_user)
    @count = current_user.no_meat_counter
    respond_to do |format|
      format.html { meat_counter_path }
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
