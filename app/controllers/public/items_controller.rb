class Public::ItemsController < ApplicationController

  def index
    @genres=Genre.all
    @items=Item.all
  end

  def serch
    @genres=Genre.all
    @items=Item.all
    if params[:genre_id]
      @genre=Genre.find(params[:genre_id])
      @items=@genre.items
    end
  end

  def show
    @genres=Genre.all
    @item=Item.find(params[:id])
    @cart_item=CartItem.new
  end
end
