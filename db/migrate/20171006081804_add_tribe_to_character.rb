class AddTribeToCharacter < ActiveRecord::Migration[5.1]
  def change
    add_column :characters, :tribe, :string, limit: 50
  end
end
