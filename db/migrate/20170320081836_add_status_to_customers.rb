class AddStatusToCustomers < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :status, :string
  end
end
