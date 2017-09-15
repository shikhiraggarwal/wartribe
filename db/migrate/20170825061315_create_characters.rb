class CreateCharacters < ActiveRecord::Migration[5.1]
  def change
    create_table :characters do |t|
      t.string :name
      t.integer :player_id
      t.integer :world_id
      t.integer :substitute1_id
      t.integer :substitute2_id
      t.string :substitute1_permission, limit: 25
      t.string :substitute2_permission, limit: 25
      t.blob :data

      t.timestamps
    end
    add_index :characters, :name, unique: true
  end
end
