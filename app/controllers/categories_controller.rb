class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    if current_user.category.nil?
      current_user.category = @category
      current_user.save
    end
    @challenges = @category.challenges
  end
end
