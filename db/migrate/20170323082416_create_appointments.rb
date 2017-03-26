class CreateAppointments < ActiveRecord::Migration[5.0]
  def change
    create_table :appointments do |t|
      t.integer :status
      t.integer :is_new_customer
      t.datetime :schedule_time
      t.text :comments
      t.integer :seller_id
      t.integer :customer_id
      t.string :address
      t.string :city
      t.string :province
      t.string :postal_code
      t.integer :windows_num
      t.integer :doors_num
      t.string :how_soon
      t.string :quotes_num
      t.string :hear_about_us
      t.string :homeoweners_at_home
      t.string :supply_install
      t.string :financing
      t.integer :installer_id

      t.timestamps
    end
  end
end
