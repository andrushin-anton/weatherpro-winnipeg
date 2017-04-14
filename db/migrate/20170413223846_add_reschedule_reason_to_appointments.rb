class AddRescheduleReasonToAppointments < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :reschedule_reason, :string
  end
end
