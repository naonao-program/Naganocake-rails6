# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
  email: "sample@sample.com",
  password: "test11"
)

Genre.create(
  [
    {
      name: "ケーキ"
    },
    {
      name: "シュークリーム"
    }
  ]
)

Customer.create!(
  last_name: '田中',
  first_name: '太郎',
  last_name_kana: 'タナカ',
  first_name_kana: 'タロウ',
  email: 'test@test.com',
  post_code: '111-1111',
  address: '東京都',
  phone_number: '000-111-2222',
  password: 'test11',
  password_confirmation: 'test11'
)

images = ["cake", "pudding", "bisket"]
names = ["ケーキ", "プリン", "ビスケット"]

for i in 1..10 do
  for j in 1..3 do
    name =  names[j-1]
    image = images[j-1]
    item = Item.new(
    genre_id: j,
    name: "#{name}#{i}",
    introduction: "#{3 * i - 2 -j}番目の商品",
    price: rand(1..10) * (j * 200),
    is_active: true
    )
    file_path = Rails.root.join("./app/assets/images/snap.jpeg")
    item.image.attach(io: File.open(file_path), filename: image)
    
    item.save
  end
end