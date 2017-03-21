class Logs < ApplicationRecord
    self.table_name = 'audits'

    paginates_per  15

    def self.search(search, current_page)
        if search
            self.where('auditable_type LIKE ?', "%#{search}%").order('id DESC').page(current_page)
        else
            self.order('id DESC').page(current_page) 
        end
    end
end