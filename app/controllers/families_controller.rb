class FamiliesController < ApplicationController
  layout 'dashboard'

  before_action :set_family, only: %i[show edit update destroy]

  def index
    @families = policy_scope(Family).includes(:users).where.not(users: { name: nil })
  end

  def show
    session[:current_family_id] = @family.id
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
      redirect_to @family, notice: 'Family was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @family
  end

  def update
    authorize @family

    if @family.update(family_params)
      redirect_to edit_family_path(@family), notice: 'Family was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @family
    @family.destroy
    redirect_to families_url, notice: 'Family was successfully destroyed.'
  end

  def invite
    @user = User.new
    @family = Family.find(session[:current_family_id])
    authorize @family
  end

  private

  def set_family
    @family = Family.find(params[:id])
  end

  def family_params
    params.require(:family).permit(:name, :description)
  end
end
