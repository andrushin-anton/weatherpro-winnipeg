class AddRescheduleTimeToAppointments < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :reschedule_time, :datetime
  end
end
