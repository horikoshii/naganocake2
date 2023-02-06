class OrderDetail < ApplicationRecord

  belongs_to :order
  belongs_to :item

  enum making_status: { wait_payment: 0, confirmation: 1, production: 2, ready_to_ship: 3, sent: 4 }

  def subtotal
    price * amount
  end

  def with_tax_price
    (price * 1.1).floor
  end

end
