class RecipesController < ApplicationController
  layout 'dashboard'
  before_action :set_family

  def index
    @recipes = policy_scope(Recipe).where(family_id: @family)
    if !params[:type].present? || (params[:type].present? && params[:type] == 'all')
      @recipes
    else
      @recipes = @recipes.where(recipe_type: params[:type])
    end
  end

  def show
    @recipe = @family.recipes.find(params[:id])
    authorize @recipe
  end

  def new
    @recipe = Recipe.new
    @recipe.family = @family
    @recipe.ingredients.build
    authorize @recipe
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.family = @family
    authorize @recipe

    if @recipe.save
      redirect_to @recipe, notice: t('recipe.created')
    else
      @recipe.ingredients.build if @recipe.ingredients.empty?
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @recipe = @family.recipes.find(params[:id])
    @recipe.ingredients.build if @recipe.ingredients.empty?
    authorize @recipe
  end

  def update
    @recipe = @family.recipes.find(params[:id])
    authorize @recipe

    if @recipe.update(recipe_params)
      redirect_to @recipe, notice: t('recipe.updated')
    else
      @recipe.ingredients.build if @recipe.ingredients.empty?
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe = @family.recipes.find(params[:id])
    authorize @recipe

    @recipe.destroy
    redirect_to family_recipes_path(@recipe.family), notice: t('recipe.destroyed')
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description, :photo, :recipe_type, ingredients_attributes: [:id, :name, :quantity, :unit, :_destroy])
  end

  def set_family
    if params[:family_id].present?
      @family = Family.find(params[:family_id])
    else
      @family = Family.find(session[:current_family])
    end
  end
end
