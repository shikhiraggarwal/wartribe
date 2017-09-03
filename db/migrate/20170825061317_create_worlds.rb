class CreateWorlds < ActiveRecord::Migration[5.1]
  def change
    create_table :worlds do |t|
      t.string :name
      t.integer :map_id
      t.integer :world_config_id
      t.string :final
      t.blob :data

      t.timestamps
    end
    add_index :worlds, :name, unique: true
  end
end
