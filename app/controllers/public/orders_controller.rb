class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @customer = current_customer
  end

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @subtotal = @order.order_details.inject(0) { |sum, order_detail| sum + order_detail.subtotal }
    @total = @order.order_details.inject(0) { |sum, order_detail| sum + order_detail.subtotal } + 800
  end

  def comfirm
    @order = Order.new(order_params)
    if params[:order][:address_number] == "1"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:address_number] == "2"
      address = Address.find(params[:order][:address_id])
      @order.postal_code = address.postal_code
      @order.address = address.address
      @order.name = address.name
    elsif params[:order][:address_number] == "3"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
      @address = Address.new(
                  postal_code: params[:order][:postal_code],
                  address: params[:order][:address],
                  name: params[:order][:name],
                  customer_id: current_customer.id
                  )
      @address.save
    end
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @subtotal = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price } + 800
  end

  def create
    cart_items = current_customer.cart_items.all
    @order = Order.new(order_params)
    @customer = current_customer
    @order.customer_id = current_customer.id
    if @order.save
      cart_items.each do |cart_item|
        order_detail = OrderDetail.new
        order_detail.item_id = cart_item.item_id
        order_detail.order_id = @order.id
        order_detail.amount = cart_item.amount
        order_detail.price = cart_item.item.price
        order_detail.save!
      end
       cart_items.destroy_all
       redirect_to orders_complete_path
    else
      @order = Order.new(order_params)
      render :new
    end
  end

  def complete
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :total_payment)
  end

end
