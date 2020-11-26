class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.text :message
      t.references :user, null: false, foreign_key: true
      t.boolean :read, default: false
      t.references :argument, null: false, foreign_key: true

      t.timestamps
    end
  end
end
