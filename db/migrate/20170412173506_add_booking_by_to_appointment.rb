class AddBookingByToAppointment < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :booking_by, :string
  end
end
