class CreateMaps < ActiveRecord::Migration[5.1]
  def change
    create_table :maps do |t|
      t.string :name
      t.integer :size, limit: 3
      t.longblob :data

      t.timestamps
    end
    add_index :maps, :name, unique: true
  end
end
