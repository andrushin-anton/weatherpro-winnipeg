class AddSoldWindowSeriesToAppointments < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :sold_window_series, :string
  end
end
