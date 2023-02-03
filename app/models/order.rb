class Order < ApplicationRecord
  has_many :order_details, dependent: :destroy
  belongs_to :customer, dependent: :destroy
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { wait_payment: 0, confirmation: 1, production: 2, ready_to_ship: 3, sent: 4 }
end
