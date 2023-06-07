class CreateSeller < ActiveRecord::Migration[6.1]
  def change 
    create_table :sellers do |table|
      table.string :name
    end
  end
end
