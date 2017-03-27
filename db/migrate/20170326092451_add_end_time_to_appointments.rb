class AddEndTimeToAppointments < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :end_time, :datetime
  end
end
