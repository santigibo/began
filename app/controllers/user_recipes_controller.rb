class UserRecipesController < ApplicationController

  def create
    recipe = Recipe.find(params[:recipe_id])
    UserRecipe.create(user: current_user, recipe: recipe)
  end

  def destroy
    recipe = UserRecipe.find(params[:id])
    recipe.destroy
    # cookbook_recipe = current_user.recipes.detect {|r| r == recipe}
    # cookbook_recipe.destroy
  end
end
