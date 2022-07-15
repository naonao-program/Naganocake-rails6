class Cart < ApplicationRecord
  has_many :items
  has_many :public_users
end
