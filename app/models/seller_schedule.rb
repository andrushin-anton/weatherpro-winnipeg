class SellerSchedule < ApplicationRecord

    def self.search(seller_id, start_time, end_time)
        self.select(:schedule_time).where('schedule_time >= ? AND schedule_time < ? AND seller_id = ?', start_time, end_time, seller_id).order('id DESC').map(&:schedule_time)
    end

    def self.remove_existing(seller_id, start_time, end_time)
        self.where('schedule_time >= ? AND schedule_time < ? AND seller_id = ?', start_time, end_time, seller_id).destroy_all
    end

end
