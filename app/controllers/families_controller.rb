class FamiliesController < ApplicationController
  layout 'dashboard'

  def index
    @families = policy_scope(Family)
  end

  def show
    @family = Family.find(params[:id])
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

  def destroy
    @family = Family.find(params[:id])
    authorize @family
    @family.destroy
    redirect_to families_url, notice: 'Family was successfully destroyed.'
  end

  def invite
    @family = Family.find(params[:family_id])
    authorize @family
  end

  private

  def family_params
    params.require(:family).permit(:name, :description)
  end
end
