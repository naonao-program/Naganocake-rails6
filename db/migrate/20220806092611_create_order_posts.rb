class CreateOrderPosts < ActiveRecord::Migration[6.1]
  def change
    create_table :order_posts do |t|
      t.integer :amount
      t.integer :making_status
      t.integer :price
      t.integer :item_id
      t.integer :order_id
      t.timestamps
    end
  end
end
