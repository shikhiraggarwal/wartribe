class CreatePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :players do |t|
      t.string :name
      t.string :world_in
      t.string :email, limit: 40
      t.boolean :email_verified
      t.string :password_hash, limit: 128
      t.string :device_id, limit: 100
      t.boolean :is_deleted
      t.blob :data

      t.timestamps
    end
    add_index :players, :name, unique: true
  end
end
