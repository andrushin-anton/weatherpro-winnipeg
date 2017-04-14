class AddSoldDueOnDeliveryToAppointment < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :sold_due_on_delivery, :datetime
  end
end
