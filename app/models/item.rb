class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :genre
  has_many :cart_items
  has_many :order_details
  
  def with_tax_price
      (price * 1.1).floor
  end
end
