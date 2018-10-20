class CreateLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :logs do |t|
      t.date :climbed_at
      t.string :comment
      t.string :status

      t.timestamps
    end
  end
end
