class Admin::Genre < ApplicationRecord
  has_many :items
end
