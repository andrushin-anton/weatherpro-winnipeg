class AddSoldNumberOfPatioDoorsToAppointments < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :sold_number_of_patio_doors, :integer
  end
end
