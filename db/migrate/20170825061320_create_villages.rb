class CreateVillages < ActiveRecord::Migration[5.1]
  def change
    create_table :villages do |t|
      t.string :name
      t.integer :character_id
      t.integer :world_id
      t.string :coords, limit: 9
      t.blob :data

      t.timestamps
    end
  end
end
