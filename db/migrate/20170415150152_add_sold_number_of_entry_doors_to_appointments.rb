class AddSoldNumberOfEntryDoorsToAppointments < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :sold_number_of_entry_doors, :integer
  end
end
