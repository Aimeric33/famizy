class FamiliesController < ApplicationController
  layout 'dashboard'

  before_action :set_family, only: %i[show edit update destroy]

  def index
    @families = policy_scope(Family).includes(:users).where.not(users: { name: nil })
    session[:current_family] = session[:current_family] || @families.first.slug
  end

  def show
    session[:current_family] = @family.slug
    authorize @family
  end

  def new
    @family = Family.new
    authorize @family
  end

  def create
    @family = Family.new(family_params)
    authorize @family

    if @family.save
      @family.family_members.create(user: current_user)
      redirect_to @family, notice: t('family.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.new
    authorize @family
  end

  def update
    authorize @family

    if @family.update(family_params)
      redirect_to edit_family_path(@family), notice: t('family.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @family
    @family.destroy
    redirect_to families_url, notice: t('family.destroyed')
  end

  private

  def set_family
    @family = Family.find(params[:id])
  end

  def family_params
    params.require(:family).permit(:name, :description)
  end
end
