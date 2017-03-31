class AddIndexesToAppointments < ActiveRecord::Migration[5.0]
  def change
    add_index :appointments, :status
    add_index :appointments, :schedule_time
    add_index :appointments, :followup_time
    add_index :appointments, :seller_id
    add_index :appointments, :installer_id
  end
end
