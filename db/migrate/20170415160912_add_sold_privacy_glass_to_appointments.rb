class AddSoldPrivacyGlassToAppointments < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :sold_privacy_glass, :string
  end
end
