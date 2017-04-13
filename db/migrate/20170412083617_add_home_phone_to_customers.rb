class AddHomePhoneToCustomers < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :home_phone, :string
  end
end
