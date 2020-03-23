class RecipesController < ApplicationController
  def index
    @challenge = Challenge.find(params[:challenge_id])
    @recipes = @challenge.recipes
    @all_recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
    @challenge = @recipe.challenges.first
  end

  def all
    if params[:query].present?
      sql_query = "name ILIKE :query OR description ILIKE :query OR time ILIKE :query OR difficulty ILIKE :query"
      @recipes = Recipe.where(sql_query, query: "%#{params[:query]}%")
      params[:query] = ""
    else
      @recipes = Recipe.all
    end
  end

end
