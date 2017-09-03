class CreateReports < ActiveRecord::Migration[5.1]
  def change
    create_table :reports do |t|
      t.integer :character_id
      t.integer :world_id
      t.blob :data

      t.timestamps
    end
  end
end
