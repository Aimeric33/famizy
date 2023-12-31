class FamiliesController < ApplicationController
  layout 'dashboard'
  def index
    @families = current_user.families
  end

  def show
    @family = Family.find(params[:id])
  end

  def new
    @family = Family.new
  end

  def create
    @family = Family.new(family_params)
    if @family.save
      @family.family_members.create(user: current_user)
      redirect_to @family, notice: 'Family was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def family_params
    params.require(:family).permit(:name)
  end
end
