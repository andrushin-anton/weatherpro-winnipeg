class AddCancelReasonToAppointments < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :cancel_reason, :string
  end
end
