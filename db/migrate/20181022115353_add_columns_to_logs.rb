class AddColumnsToLogs < ActiveRecord::Migration[5.2]
  def change
    add_reference :logs, :user, foreign_key: true
    add_reference :logs, :problem, foreign_key: true
  end
end
