class RecipesController < ApplicationController
  layout 'dashboard'

  def index
    @recipes = policy_scope(Recipe).where(family_id: params[:family_id])
  end

  def show
    @recipe = Recipe.find(params[:id])
    authorize @recipe
  end

  def new
    @recipe = Recipe.new
    @recipe.family = Family.find(params[:family_id])
    authorize @recipe
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.family = Family.find(params[:family_id])
    authorize @recipe

    if @recipe.save
      redirect_to @recipe, notice: t('recipe.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    authorize @recipe

    @recipe.destroy
    redirect_to family_recipes_path(@recipe.family), notice: t('recipe.destroyed')
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description, :photo)
  end
end
