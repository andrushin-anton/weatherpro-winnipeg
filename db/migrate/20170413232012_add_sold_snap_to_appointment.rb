class AddSoldSnapToAppointment < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :sold_snap, :string
  end
end
