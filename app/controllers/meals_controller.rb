class MealsController < ApplicationController
  layout 'dashboard'

  def index
    @meals = policy_scope(Meal).where(family_id: Family.find(params[:family_id]))
    start_date = params[:start_date].present? ? params[:start_date].to_date : Date.today
    @meals = @meals.where(date: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week)
                    .joins(:recipe)
                    .order(:recipe_type)
  end

  def new
    @meal = Meal.new
    @meal_date = params[:meal_date]
    @meal_type = params[:meal_type]
    @meal.family = Family.find(params[:family_id])

    authorize @meal
  end

  def create
    @meal = Meal.new(date: params[:meal][:date], meal_type: params[:meal][:meal_type])
    @meal.recipe = Recipe.find(params[:meal][:recipe])
    @meal.family = Family.find(params[:family_id])

    authorize @meal

    if @meal.save
      redirect_to family_meals_path(@meal.family, start_date: @meal.date), notice: t('meal.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @meal = Meal.find(params[:id])
    authorize @meal

    @meal.destroy
    redirect_to family_meals_path(@meal.family, start_date: @meal.date), notice: t('meal.destroyed')
  end

  private

  def meal_params
    params.require(:meal).permit(:date, :recipe, :meal_type)
  end
end
