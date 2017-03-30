class Appointment < ApplicationRecord
    audited
    validates :address, presence: true
    validates :customer_id, presence: true, :unless => :is_new_customer?
    validates :new_customer_first_name, presence: true, :if => :is_new_customer?
    validates :new_customer_last_name, presence: true, :if => :is_new_customer?
    validates :new_customer_phone, presence: true, :if => :is_new_customer?
    validates :new_customer_email, allow_blank: true, length: { maximum: 70 }, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, :if => :is_new_customer?
    
    belongs_to :customer

    enum statuses: { assigned: :assigned, lead: :lead, reschedule: :reschedule, upSell: :upSell, referral: :referral, cancelled: :cancelled, sold: :sold, followUp: :followUp }

    attr_accessor :new_customer_first_name, :new_customer_last_name, :new_customer_phone, :new_customer_email

    def is_new_customer?        
        if self.new_record? && self.is_new_customer == 1
            return true
        else
            return false
        end
    end

    def self.search(user, search, start_time, end_time)
        if search
            if user.role == 'admin' || user.role == 'manager' 
                
                sellers_ids = User.search_sellers(search)
                if sellers_ids.length > 0
                    self.joins(:customer).where('address LIKE ? OR city LIKE ? OR customers.first_name LIKE ? OR customers.last_name LIKE ? OR seller_id IN(?)', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "#{sellers_ids.join(",")}").order('id DESC').all
                else
                    self.joins(:customer).where('address LIKE ? OR city LIKE ? OR customers.first_name LIKE ? OR customers.last_name LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%").order('id DESC').all
                end
                
            elsif user.role == 'seller'
                self.where('(address LIKE ? OR city LIKE ?) AND seller_id = ?', "%#{search}%", "%#{search}%", user.id).order('id DESC').all
            else
                self.where('(address LIKE ? OR city LIKE ?) AND installer_id = ?', "%#{search}%", "%#{search}%", user.id).order('id DESC').all
            end                
        else
            if user.role == 'admin' || user.role == 'manager' 
                self.where('schedule_time >= ? AND schedule_time < ?', start_time, end_time).order('id DESC').all
            elsif user.role == 'seller'
                self.where('schedule_time >= ? AND schedule_time < ? AND seller_id = ?', start_time, end_time, user.id).order('id DESC').all
            else
                self.where('schedule_time >= ? AND schedule_time < ? AND installer_id = ?', start_time, end_time, user.id).order('id DESC').all
            end
        end
    end

    def self.search_by_seller(user, seller_id, search, start_time, end_time)
        if search    
            self.joins(:customer).where('(address LIKE ? OR city LIKE ? OR customers.first_name LIKE ? OR customers.last_name LIKE ?) AND seller_id = ?', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "#{seller_id}").order('id DESC').all           
        else
            self.where('schedule_time >= ? AND schedule_time < ? AND seller_id = ?', start_time, end_time, seller_id).order('id DESC').all
        end
    end

    def self.search_by_installer(user, installer_id, search, start_time, end_time)
        if search    
            self.joins(:customer).where('(address LIKE ? OR city LIKE ? OR customers.first_name LIKE ? OR customers.last_name LIKE ?) AND installer_id = ?', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "#{installer_id}").order('id DESC').all           
        else
            self.where('schedule_time >= ? AND schedule_time < ? AND installer_id = ?', start_time, end_time, installer_id).order('id DESC').all
        end
    end

    def color
        case self.status.to_sym
        when :lead
            return '#583030'
        when :assigned
            return '#FF902F'
        when :reschedule
            return '#3A29D2'
        when :upSell
            return '#d28f3e'
        when :referral
            return '#d28f3e'
        when :cancelled
            return '#EC2D26'
        when :sold
            return '#4DB02F'
        when :followUp
            return '#B326C9'
        else
            return '#FFF'
        end
    end

    def details_for_quick_view
        {customer: self.customer.full_name, address: self.address, city: self.city, province: self.province}
    end

    before_create do
        if is_new_customer?
            # Create a new customer and assing to this Appointment            
            customer = Customer.new
            customer.first_name = self.new_customer_first_name
            customer.last_name = self.new_customer_last_name
            customer.phone = self.new_customer_phone
            customer.email = self.new_customer_email
            customer.save
            
            self.customer_id = customer.id
        end
    end

end
