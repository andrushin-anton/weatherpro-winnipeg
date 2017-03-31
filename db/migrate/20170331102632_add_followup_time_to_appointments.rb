class AddFollowupTimeToAppointments < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :followup_time, :datetime
  end
end
