class AddSoldTotalToAppointment < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :sold_total, :decimal, :precision => 8, :scale => 2
  end
end
