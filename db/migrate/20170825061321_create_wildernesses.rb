class CreateWildernesses < ActiveRecord::Migration[5.1]
  def change
    create_table :wildernesses do |t|
      t.string :name
      t.string :coords, limit: 9
      t.integer :world_id
      t.blob :data

      t.timestamps
    end
  end
end
