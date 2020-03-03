class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    if current_user.category_id.nil?
      current_user.category_id = params[:id]
      current_user.save
    end
    @challenges = @category.challenges
  end
end
