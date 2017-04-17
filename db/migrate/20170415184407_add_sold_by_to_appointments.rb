class AddSoldByToAppointments < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :sold_by, :string
  end
end
