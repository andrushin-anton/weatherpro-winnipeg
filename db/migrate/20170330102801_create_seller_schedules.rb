class CreateSellerSchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :seller_schedules do |t|
      t.datetime :schedule_time
      t.integer :seller_id

      t.timestamps
    end
  end
end
