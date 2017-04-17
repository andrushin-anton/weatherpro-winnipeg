class AddSoldGrillsTypeToAppointments < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :sold_grills_type, :string
  end
end
