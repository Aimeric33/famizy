class MealsController < ApplicationController
  layout 'dashboard'

  def index
    @meals = policy_scope(Meal).where(family_id: params[:family_id])
  end

  def new
    @meal = Meal.new
    @meal.family = Family.find(params[:family_id])

    authorize @meal
  end

  def create
    @meal = Meal.new(meal_params)
    @meal.family = Family.find(params[:family_id])

    authorize @meal

    if @meal.save
      redirect_to family_meals_path(@meal.family), notice: t('meal.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @meal = Meal.find(params[:id])
    authorize @meal

    @meal.destroy
    redirect_to family_meals_path(@meal.family), notice: t('meal.destroyed')
  end

  private

  def meal_params
    params.require(:meal).permit(:date, :recipe_id)
  end
end
