class InstallerSchedule < ApplicationRecord

    def self.search_by_date_range(start_time, end_time)
        self.where('schedule_time >= ? AND schedule_time < ?', start_time, end_time).order('id ASC').all
    end

    def self.installer_ids_by_date_range(start_time, end_time)
        self.select(:installer_id).where('schedule_time >= ? AND schedule_time < ?', start_time, end_time).order('id ASC').map(&:installer_id)
    end

    def self.search(installer_id, start_time, end_time)
        self.select(:schedule_time).where('schedule_time >= ? AND schedule_time < ? AND installer_id = ?', start_time, end_time, installer_id).order('id ASC').map(&:schedule_time)
    end

    def self.remove_existing(installer_id, start_time, end_time)
        self.where('schedule_time >= ? AND schedule_time < ? AND installer_id = ?', start_time, end_time, installer_id).destroy_all
    end

end
