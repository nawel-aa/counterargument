class RemoveArgumentFromArguments < ActiveRecord::Migration[6.0]
  def change
    remove_reference :arguments, :argument
  end
end
