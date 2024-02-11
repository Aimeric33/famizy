class ListItemsController < ApplicationController
  def create
    @list = List.find(params[:list_id])
    @list_item = @list.list_items.new(list_item_params)
    authorize @list_item

    @list_item.save
    redirect_to list_path(@list)
  end

  def update
    @list_item = ListItem.find(params[:id])
    authorize @list_item

    @list_item.update(list_item_params)
    redirect_to list_path(@list_item.list), status: :see_other
  end

  def destroy
    @list_item = ListItem.find(params[:id])
    authorize @list_item

    @list_item.destroy
    redirect_to list_path(@list_item.list), status: :see_other
  end

  private

  def list_item_params
    params.require(:list_item).permit(:name, :done)
  end
end
