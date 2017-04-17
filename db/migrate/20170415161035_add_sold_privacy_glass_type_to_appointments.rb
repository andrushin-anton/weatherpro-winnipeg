class AddSoldPrivacyGlassTypeToAppointments < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :sold_privacy_glass_type, :string
  end
end
