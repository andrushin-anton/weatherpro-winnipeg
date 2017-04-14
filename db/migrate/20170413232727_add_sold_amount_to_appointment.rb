class AddSoldAmountToAppointment < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :sold_amount, :decimal, :precision => 8, :scale => 2
  end
end
