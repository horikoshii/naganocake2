class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :genre
  
  def with_tax_price
      (price * 1.1).floor
  end
end
