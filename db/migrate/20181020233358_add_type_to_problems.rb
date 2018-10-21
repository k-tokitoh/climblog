class AddTypeToProblems < ActiveRecord::Migration[5.2]
  def change
    add_column :problems, :type, :string
  end
end
