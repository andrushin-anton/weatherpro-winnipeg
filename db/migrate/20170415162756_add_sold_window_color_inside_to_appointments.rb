class AddSoldWindowColorInsideToAppointments < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :sold_window_color_inside, :string
  end
end
