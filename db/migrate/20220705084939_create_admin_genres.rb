class CreateAdminGenres < ActiveRecord::Migration[6.1]
  def change
    create_table :admin_genres do |t|
      t.string :name
      t.integer :genre_id
      t.timestamps
    end
  end
end
