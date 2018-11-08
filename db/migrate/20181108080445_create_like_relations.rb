class CreateLikeRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :like_relations do |t|
      t.references :user, foreign_key: true
      t.references :log, foreign_key: true

      t.timestamps
      t.index [:user_id, :log_id], unique: true
    end
  end
end
