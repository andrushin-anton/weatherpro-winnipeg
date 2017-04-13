class RenameColumn < ActiveRecord::Migration[5.0]
  def self.up
    rename_column :appointments, :sealt, :sealed
  end

  def self.down
    
  end
end
