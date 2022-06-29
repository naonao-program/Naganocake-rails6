class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  with_options presence: true do
    validates :last_name
    validates :first_name
    validates :last_name_kana
    validates :first_name_kana
    validates :post_code
    validates :address
    validates :phone_number
  end
  # 退会済みのユーザが同じアカウントでログインできないように制約
  def active_for_authentication?
    super && (delete == false)
  end
end
