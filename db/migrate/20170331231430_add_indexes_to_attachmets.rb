class AddIndexesToAttachmets < ActiveRecord::Migration[5.0]
  def change
    add_index :attachments, :appointment_id
  end
end
