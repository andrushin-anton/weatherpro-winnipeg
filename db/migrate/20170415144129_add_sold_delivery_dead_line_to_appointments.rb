class AddSoldDeliveryDeadLineToAppointments < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :sold_delivery_dead_line, :datetime
  end
end
