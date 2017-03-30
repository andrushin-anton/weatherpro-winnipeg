class CreateInstallerSchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :installer_schedules do |t|
      t.datetime :schedule_time
      t.integer :installer_id

      t.timestamps
    end
  end
end
