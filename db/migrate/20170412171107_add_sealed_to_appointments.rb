class AddSealedToAppointments < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :sealt, :integer
  end
end
