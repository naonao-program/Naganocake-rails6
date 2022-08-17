class Order < ApplicationRecord
  belongs_to :customer
  has_many :items
  has_many :order_posts
  
  enum payment_method: {
    credit_card: 0,
    transfer: 1 
  }
end
