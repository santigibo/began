class UserRecipesController < ApplicationController

  def create_or_destroy
    recipe = Recipe.find(params[:recipe_id])
    if current_user.recipes.include? recipe
      user_recipe = UserRecipe.all.detect {|ur| ur.user == current_user && ur.recipe == recipe}
      user_recipe.destroy
    else
      UserRecipe.create(user: current_user, recipe: recipe)
      flash.alert = "Added to your cookbook"
    end
  end
end
