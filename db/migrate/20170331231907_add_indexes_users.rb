class AddIndexesUsers < ActiveRecord::Migration[5.0]
  def change
    add_index :users, :role
    add_index :users, :status
  end
end
