class UserRecipesController < ApplicationController

  def create
    recipe = Recipe.find(params[:recipe_id])
    UserRecipe.create(user: current_user, recipe: recipe)
  end

end
