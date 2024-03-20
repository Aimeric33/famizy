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
    @recipe.ingredients.build
    authorize @recipe
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.family = Family.find(params[:family_id])
    authorize @recipe

    if @recipe.save
      redirect_to @recipe, notice: t('recipe.created')
    else
      @recipe.ingredients.build if @recipe.ingredients.empty?
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @recipe.ingredients.build if @recipe.ingredients.empty?
    authorize @recipe
  end

  def update
    @recipe = Recipe.find(params[:id])
    authorize @recipe


    if @recipe.update(recipe_params)
      redirect_to @recipe, notice: t('recipe.updated')
    else
      @recipe.ingredients.build if @recipe.ingredients.empty?
      render :edit, status: :unprocessable_entity
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
    params.require(:recipe).permit(:name, :description, :photo, :meal_type, ingredients_attributes: [:id, :name, :quantity, :unit, :_destroy])
  end
end
