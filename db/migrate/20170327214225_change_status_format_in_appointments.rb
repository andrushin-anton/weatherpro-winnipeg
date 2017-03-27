class ChangeStatusFormatInAppointments < ActiveRecord::Migration[5.0]
  def up
    change_column :appointments, :status, :string 
  end

  def down
    change_column :appointments, :status, :integer
  end
end
