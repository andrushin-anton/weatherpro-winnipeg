class AddTypeToAppointment < ActiveRecord::Migration[5.0]
  def self.up
    rename_column :appointments, :type, :app_type
  end

  def self.down
    
  end
end
