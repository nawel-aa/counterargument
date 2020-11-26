class CreateArgumentParentChildRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :argument_parent_child_relationships do |t|
      t.references :child, null: false, foreign_key: { to_table: :arguments }
      t.references :parent, null: false, foreign_key: { to_table: :arguments }

      t.timestamps
    end
  end
end
