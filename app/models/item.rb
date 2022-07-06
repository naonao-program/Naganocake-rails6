class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :genre

  with_options precense: true do 
    validates :genre_id
    validates :name
    validates :image_id
    validates :price
    validates :is_active
  end
end
