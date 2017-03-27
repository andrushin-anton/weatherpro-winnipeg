class Appointment < ApplicationRecord
    audited
    enum status: [:Assigned, :Lead, :Reschedule, :UpSell, :Referral, :Cancelled, :Sold, :FollowUp]

end
