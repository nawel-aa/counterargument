class CreateArguments < ActiveRecord::Migration[6.0]
  def change
    create_table :arguments do |t|
      t.references :user, null: false, foreign_key: true
      t.text :content
      t.string :source
      t.references :argument, null: false, foreign_key: true

      t.timestamps
    end
  end
end
