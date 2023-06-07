class CreateHouses < ActiveRecord::Migration[6.1]
  def change
    create_table :houses do |t|
      t.integer :location_id
      t.integer :category_id
      t.integer :seller_id
      t.float :price
      t.string :description
      t.integer :size_in_sqft 
      t.string :image
    end
  end
end
