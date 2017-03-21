class AddEmailToCustomers < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :email, :string
  end
end
