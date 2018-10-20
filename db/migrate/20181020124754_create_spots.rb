class CreateSpots < ActiveRecord::Migration[5.2]
  def change
    create_table :spots do |t|
      t.string :name
      t.string :type
      t.timestamps
      
      # gym only
      t.string :prefecture
      t.string :adress
      t.string :url
      
      # area only
      t.string :region
      
    end
  end
end
