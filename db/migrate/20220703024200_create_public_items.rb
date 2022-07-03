class CreatePublicItems < ActiveRecord::Migration[6.1]
  def change
    create_table :public_items do |t|

      t.timestamps
    end
  end
end
