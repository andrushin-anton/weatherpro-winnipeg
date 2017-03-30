class InstallerSchedule < ApplicationRecord

    def self.search(installer_id, start_time, end_time)
        self.select(:schedule_time).where('schedule_time >= ? AND schedule_time < ? AND installer_id = ?', start_time, end_time, installer_id).order('id DESC').map(&:schedule_time)
    end

    def self.remove_existing(installer_id, start_time, end_time)
        self.where('schedule_time >= ? AND schedule_time < ? AND installer_id = ?', start_time, end_time, installer_id).destroy_all
    end

end
