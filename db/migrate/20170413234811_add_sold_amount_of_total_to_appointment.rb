class AddSoldAmountOfTotalToAppointment < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :sold_amount_of_total, :decimal, :precision => 8, :scale => 2
  end
end
