class AddHiddenToArgument < ActiveRecord::Migration[6.0]
  def change
    add_column :arguments, :hidden, :boolean
  end
end
