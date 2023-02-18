class Admin::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @subtotal = @order.order_details.inject(0) { |sum, order_detail| sum + order_detail.subtotal }
    @total = @order.order_details.inject(0) { |sum, order_detail| sum + order_detail.subtotal } + 800
  end
end
