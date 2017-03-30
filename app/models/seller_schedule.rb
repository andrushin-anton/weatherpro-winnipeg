class SellerSchedule < ApplicationRecord

    def self.search_by_date_range(start_time, end_time)
        self.where('schedule_time >= ? AND schedule_time < ?', start_time, end_time).order('id DESC').all
    end

    def self.seller_ids_by_date_range(start_time, end_time)
        self.select(:seller_id).where('schedule_time >= ? AND schedule_time < ?', start_time, end_time).order('id DESC').map(&:seller_id)
    end

    def self.search(seller_id, start_time, end_time)
        self.select(:schedule_time).where('schedule_time >= ? AND schedule_time < ? AND seller_id = ?', start_time, end_time, seller_id).order('id DESC').map(&:schedule_time)
    end

    def self.remove_existing(seller_id, start_time, end_time)
        self.where('schedule_time >= ? AND schedule_time < ? AND seller_id = ?', start_time, end_time, seller_id).destroy_all
    end

end
