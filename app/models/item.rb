class Item < ApplicationRecord
  belongs_to :genre
  has_one_attached :image
  
  with_options precense: true do 
    validates :name
    validates :introduction
    validates :image_id
    validates :price
    validates :is_active
    validates :genre_id
  end
end
