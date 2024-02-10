class ListsController < ApplicationController
  layout 'dashboard'

  def index
    @lists = policy_scope(List).where(family_id: params[:family_id])
  end

  def show
    @list = List.find(params[:id])
    authorize @list
  end

  def new
    @list = List.new
    @list.family = Family.find(params[:family_id])
    authorize @list
  end

  def create
    @list = List.new(list_params)
    @list.family = Family.find(params[:family_id])
    authorize @list

    if @list.save
      redirect_to @list, notice: 'List was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def list_params
    params.require(:list).permit(:name, :list_type)
  end
end
