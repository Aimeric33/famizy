class ListItemsController < ApplicationController
  def create
    @list = List.find(params[:list_id])
    @list_item = @list.list_items.new(list_item_params)
    authorize @list_item

    @list_item.save
    # redirect_to list_path(@list)
  end

  private

  def list_item_params
    params.require(:list_item).permit(:name)
  end
end
