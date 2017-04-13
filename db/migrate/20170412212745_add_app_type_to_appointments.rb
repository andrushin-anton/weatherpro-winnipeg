class AddAppTypeToAppointments < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :app_type, :string
  end
end
