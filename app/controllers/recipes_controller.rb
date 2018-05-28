class RecipesController < ApplicationController
  def new
    @recipe = Recipe.new
    @ingredients = Ingredient.all
  end

  def show
    #not totally necessary I think.
    #doesnt show ingredients
    @recipe = Recipe.find(params[:id])
  end

  def create
    @recipe = Recipe.create(recipe_params)
    if params[:ingredient_ids]
      params[:ingredient_ids].each do |id|
        @recipe.ingredients << Ingredient.find(id)
      end
    end
    redirect_to recipe_path(@recipe)
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    @recipe.update(recipe_params)
    if params[:ingredient_ids]
      params[:ingredient_ids].each do |id|
        @recipe.ingredients << Ingredient.find(id)
      end
    else
      @recipe.ingredients.clear
    end

    redirect_to @recipe
  end



  private
  def recipe_params
    params.require("recipe").permit(:name)
  end
end
