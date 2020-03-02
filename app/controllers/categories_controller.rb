class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @challenges = @category.challenges
  end
end
