class RecipesController < ApplicationController
  def index
    @challenge = Challenge.find(params[:challenge_id])
    @recipes = @challenge.recipes
    @all_recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def all
    @recipes = Recipe.all
  end
end
