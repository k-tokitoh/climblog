class CreateFollowRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :follow_relations do |t|
      t.references :following, foreign_key: { to_table: :users }
      t.references :followed, foreign_key: { to_table: :users }

      t.timestamps
      t.index [:following_id, :followed_id], unique: true
    end
  end
end
