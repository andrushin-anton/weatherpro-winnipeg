class AddIndexesToInstallerSchedules < ActiveRecord::Migration[5.0]
  def change
    add_index :installer_schedules, :schedule_time
    add_index :installer_schedules, :installer_id
  end
end
