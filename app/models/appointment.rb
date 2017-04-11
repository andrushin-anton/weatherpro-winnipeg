class Appointment < ApplicationRecord
    audited
    on_change :seller_id, :process_status

    validates :address, presence: true
    validates :customer_id, presence: true, :unless => :is_new_customer?
    validates :new_customer_first_name, presence: true, :if => :is_new_customer?
    validates :new_customer_last_name, presence: true, :if => :is_new_customer?
    validates :new_customer_phone, presence: true, :if => :is_new_customer?
    validates :new_customer_email, allow_blank: true, length: { maximum: 70 }, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, :if => :is_new_customer?
    
    belongs_to :customer
    has_many :attachments

    enum statuses: {confirmed: :Confirmed, assigned: :Assigned, lead: :Lead, reschedule: :Reschedule, upSell: :UpSell, referral: :Referral, cancelled: :Cancelled, sold: :Sold, followUp: :FollowUp, telemarketing: :Telemarketing }

    attr_accessor :new_customer_first_name, :new_customer_last_name, :new_customer_phone, :new_customer_email

    def is_new_customer?        
        if self.new_record? && self.is_new_customer == 1
            return true
        else
            return false
        end
    end

    def process_status(attr_name, old_value, new_value)
        if old_value.nil? || old_value == ''
            self.status = 'Assigned' if new_value != ''
        end
    end
    

    #Appointments
    def self.search(user, search, start_time, end_time)
        if search
            #Admins and Managers
            if user.role == 'admin' || user.role == 'manager' || user.role == 'master'
                #search for sellers and get their ids
                sellers_ids = User.search_sellers(search)
                if sellers_ids.length > 0
                    self.joins(:customer).where(
                        'appointments.status != ? AND (address LIKE ? OR city LIKE ? OR customers.first_name LIKE ? OR customers.last_name LIKE ? OR seller_id IN(?))', 
                        "#{self.statuses[:followUp]}", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "#{sellers_ids.join(",")}"
                    ).order('id DESC').all
                else
                    self.joins(:customer).where(
                        'appointments.status != ? AND (address LIKE ? OR city LIKE ? OR customers.first_name LIKE ? OR customers.last_name LIKE ?)', 
                        "#{self.statuses[:followUp]}", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"
                    ).order('id DESC').all
                end

            #Telemarketers
            elsif user.role == 'telemarketer'
                self.joins(:customer).where(
                    'schedule_time >= ? AND appointments.status = ? AND (address LIKE ? OR city LIKE ? OR customers.first_name LIKE ? OR customers.last_name LIKE ?)', 
                    Date.today, "#{self.statuses[:telemarketing]}", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"
                ).order('id DESC').all

            #Sellers only
            elsif user.role == 'seller'
                self.where(
                    'status != ? AND (address LIKE ? OR city LIKE ?) AND seller_id = ?', 
                    "#{self.statuses[:followUp]}", "%#{search}%", "%#{search}%", user.id
                ).order('id DESC').all

            #Installers
            else
                self.where(
                    'status != ? AND (address LIKE ? OR city LIKE ?) AND installer_id = ?', 
                    "#{self.statuses[:followUp]}", "%#{search}%", "%#{search}%", user.id
                    ).order('id DESC').all
            end                

        else
            if user.role == 'admin' || user.role == 'manager' || user.role == 'master'
                self.where(
                    'status != ? AND schedule_time >= ? AND schedule_time < ?',
                    "#{self.statuses[:followUp]}", start_time, end_time
                ).order('id DESC').all
            elsif user.role == 'telemarketer'
                self.where(
                    'status = ? AND schedule_time >= ? AND schedule_time < ?', 
                    "#{self.statuses[:telemarketing]}", start_time, end_time
                ).order('id DESC').all
            elsif user.role == 'seller'
                self.where(
                    'status != ? AND schedule_time >= ? AND schedule_time < ? AND seller_id = ?', 
                    "#{self.statuses[:followUp]}", start_time, end_time, user.id
                ).order('id DESC').all
            else
                self.where(
                    'status != ? AND schedule_time >= ? AND schedule_time < ? AND installer_id = ?', 
                    "#{self.statuses[:followUp]}", start_time, end_time, user.id
                ).order('id DESC').all
            end
        end
    end

    def self.search_followups(user, search, start_time, end_time)
        if search
            if user.role == 'admin' || user.role == 'manager' || user.role == 'master'
                
                sellers_ids = User.search_sellers(search)
                if sellers_ids.length > 0
                    self.joins(:customer).where(
                        'appointments.status = ? AND (address LIKE ? OR city LIKE ? OR customers.first_name LIKE ? OR customers.last_name LIKE ? OR seller_id IN(?))', 
                        "#{self.statuses[:followUp]}", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "#{sellers_ids.join(",")}"
                    ).order('id DESC').all
                else
                    self.joins(:customer).where(
                        'appointments.status = ? AND (address LIKE ? OR city LIKE ? OR customers.first_name LIKE ? OR customers.last_name LIKE ?)', 
                        "#{self.statuses[:followUp]}", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"
                    ).order('id DESC').all
                end
                
            elsif user.role == 'seller'
                self.where(
                    'status = ? AND (address LIKE ? OR city LIKE ?) AND seller_id = ?', 
                    "#{self.statuses[:followUp]}", "%#{search}%", "%#{search}%", user.id
                ).order('id DESC').all

            elsif user.role == 'installer'
                self.where(
                    'status = ? AND (address LIKE ? OR city LIKE ?) AND installer_id = ?', 
                    "#{self.statuses[:followUp]}", "%#{search}%", "%#{search}%", user.id
                ).order('id DESC').all

            else
                return []
            end                
        else
            if user.role == 'admin' || user.role == 'manager' || user.role == 'master' 
                self.where('status = ? AND followup_time >= ? AND followup_time < ?', "#{self.statuses[:followUp]}", start_time, end_time).order('id DESC').all
            elsif user.role == 'seller'
                self.where('status = ? AND followup_time >= ? AND followup_time < ? AND seller_id = ?', "#{self.statuses[:followUp]}", start_time, end_time, user.id).order('id DESC').all
            elsif user.role == 'installer'
                self.where('status = ? AND followup_time >= ? AND followup_time < ? AND installer_id = ?', "#{self.statuses[:followUp]}", start_time, end_time, user.id).order('id DESC').all
            else
                return []
            end
        end
    end

    #Sellers
    def self.search_by_seller(user, seller_id, search, start_time, end_time)
        if search    
            self.joins(:customer).where(
                'appointments.status != ? AND (address LIKE ? OR city LIKE ? OR customers.first_name LIKE ? OR customers.last_name LIKE ?) AND seller_id = ?',
                "#{self.statuses[:followUp]}", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "#{seller_id}"
            ).order('id DESC').all           
        else
            self.where(
                'status != ? AND schedule_time >= ? AND schedule_time < ? AND seller_id = ?',
                "#{self.statuses[:followUp]}", start_time, end_time, seller_id
            ).order('id DESC').all
        end
    end

    def self.search_followups_by_seller(user, seller_id, search, start_time, end_time)
        if search    
            self.joins(:customer).where(
                'appointments.status = ? AND (address LIKE ? OR city LIKE ? OR customers.first_name LIKE ? OR customers.last_name LIKE ?) AND seller_id = ?',
                "#{self.statuses[:followUp]}", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "#{seller_id}"
            ).order('id DESC').all           
        else
            self.where(
                'status = ? AND followup_time >= ? AND followup_time < ? AND seller_id = ?',
                "#{self.statuses[:followUp]}", start_time, end_time, seller_id
            ).order('id DESC').all
        end
    end

    #Installers
    def self.search_by_installer(user, installer_id, search, start_time, end_time)
        if search    
            self.joins(:customer).where(
                'appointments.status != ? AND (address LIKE ? OR city LIKE ? OR customers.first_name LIKE ? OR customers.last_name LIKE ?) AND installer_id = ?',
                "#{self.statuses[:followUp]}", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "#{installer_id}"
            ).order('id DESC').all           
        else
            self.where(
                'status != ? AND schedule_time >= ? AND schedule_time < ? AND installer_id = ?',
                "#{self.statuses[:followUp]}", start_time, end_time, installer_id
            ).order('id DESC').all
        end
    end

    def self.search_followups_by_installer(user, installer_id, search, start_time, end_time)
        if search    
            self.joins(:customer).where(
                'appointments.status = ? AND (address LIKE ? OR city LIKE ? OR customers.first_name LIKE ? OR customers.last_name LIKE ?) AND installer_id = ?',
                "#{self.statuses[:followUp]}", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "#{installer_id}"
            ).order('id DESC').all           
        else
            self.where(
                'status = ? AND followup_time >= ? AND followup_time < ? AND installer_id = ?',
                "#{self.statuses[:followUp]}", start_time, end_time, installer_id
            ).order('id DESC').all
        end
    end

    

    def color
        
        case self.status.to_sym
        
        when :Lead
            return '#583030'
        when :Assigned
            return '#FF902F'
        when :Confirmed
            return '#FF902F'
        when :Telemarketing
            return '#3A29D2'
        when :Reschedule
            return '#3A29D2'
        when :UpSell
            return '#d28f3e'
        when :Referral
            return '#d28f3e'
        when :Cancelled
            return '#EC2D26'
        when :Sold
            return '#4DB02F'
        when :FollowUp
            return '#B326C9'
        else
            return '#FFF'
        end
    end


    def info_icon
        
        case self.status.to_sym
        
        when :Lead
            return '<img src="/images/unassigned.gif" style="width:20px;float:right;padding-right:1px;">'
        when :Reschedule
            return '<img src="/images/unassigned.gif" style="width:20px;float:right;padding-right:1px;">'
        when :Telemarketing
            return '<img src="/images/unassigned.gif" style="width:20px;float:right;padding-right:1px;">'
        when :Referral
            return '<img src="/images/unassigned.gif" style="width:20px;float:right;padding-right:1px;">'
        when :UpSell
            return '<img src="/images/unassigned.gif" style="width:20px;float:right;padding-right:1px;">'
        when :Assigned
            return '<img src="/images/not_confirmed.png" style="width:20px;float:right;padding-right:1px;">'
        when :Confirmed
            return '<img src="/images/checkmark.png" style="width:20px;float:right;padding-right:1px;">'
        else
            return ''
        end
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
