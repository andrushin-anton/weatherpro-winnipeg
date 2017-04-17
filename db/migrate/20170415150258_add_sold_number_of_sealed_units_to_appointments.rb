class AddSoldNumberOfSealedUnitsToAppointments < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :sold_number_of_sealed_units, :integer
  end
end
