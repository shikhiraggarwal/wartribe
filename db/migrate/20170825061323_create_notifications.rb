class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.string :title
      t.text :description
      t.text :recipient

      t.timestamps
    end
  end
end
