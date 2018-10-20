class CreateProblems < ActiveRecord::Migration[5.2]
  def change
    create_table :problems do |t|
      t.integer :grade
      t.timestamps
      t.references :spot, foreign_key: true
      
      # outdoor only
      t.string :name
    end
  end
end
