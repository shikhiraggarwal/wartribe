class CreateWorldConfigs < ActiveRecord::Migration[5.1]
  def change
    create_table :world_configs do |t|
      t.string :name
      t.blob :data

      t.timestamps
    end
    add_index :world_configs, :name, unique: true
  end
end
