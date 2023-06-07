class CreateLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :locations do |table|
      table.string :name
    end
  end
end
