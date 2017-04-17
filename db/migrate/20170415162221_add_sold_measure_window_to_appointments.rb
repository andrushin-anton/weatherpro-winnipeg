class AddSoldMeasureWindowToAppointments < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :sold_measure_window, :string
  end
end
