class AddSoldGrillsToAppointments < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :sold_grills, :string
  end
end
