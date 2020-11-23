class CreateTagsArguments < ActiveRecord::Migration[6.0]
  def change
    create_table :tags_arguments do |t|
      t.references :tag, null: false, foreign_key: true
      t.references :argument, null: false, foreign_key: true

      t.timestamps
    end
  end
end
