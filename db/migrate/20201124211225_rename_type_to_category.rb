class RenameTypeToCategory < ActiveRecord::Migration[6.0]
  def change
    rename_column :votes, :type, :category
  end
end
