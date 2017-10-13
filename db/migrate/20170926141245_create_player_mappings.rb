class CreatePlayerMappings < ActiveRecord::Migration[5.1]
  def change
    create_table :player_mappings do |t|
      t.integer :user_id
      t.string :device_id, limit: 50

      t.timestamps
    end
  end
end
