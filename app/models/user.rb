class User < ApplicationRecord
    has_secure_password

    validates :email, presence: true, uniqueness: true, length: { maximum: 70 }, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
    validates :email, :uniqueness => true, on: [:save]

    def self.roles
        {admin: :admin, manager: :manager , seller: :seller, installer: :installer}
    end

end
