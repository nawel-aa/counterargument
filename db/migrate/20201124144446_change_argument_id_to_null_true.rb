class ChangeArgumentIdToNullTrue < ActiveRecord::Migration[6.0]
  def change
    change_column_null :arguments, :argument_id, true
  end
end
