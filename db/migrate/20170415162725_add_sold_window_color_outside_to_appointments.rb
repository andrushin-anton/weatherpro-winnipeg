class AddSoldWindowColorOutsideToAppointments < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :sold_window_color_outside, :string
  end
end
