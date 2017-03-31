class AddIndexesToSellerSchedules < ActiveRecord::Migration[5.0]
  def change
    add_index :seller_schedules, :schedule_time
    add_index :seller_schedules, :seller_id
  end
end
