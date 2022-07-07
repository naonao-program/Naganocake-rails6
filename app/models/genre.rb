class Genre < ApplicationRecord
  has_many :items
  validates :name, presense: true
end
