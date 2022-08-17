class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items
  has_many :order_posts
  has_one_attached :image

  with_options presence: true do
    validates :name
    validates :introduction
    validates :price
    validates :is_active
  end

  def with_tax_price
    (price * 1.1).ceil
    # ceilは切り上げ、floorが切り捨て、roundが四捨五入
  end
end
