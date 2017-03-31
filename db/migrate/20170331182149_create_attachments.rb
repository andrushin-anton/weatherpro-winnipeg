class CreateAttachments < ActiveRecord::Migration[5.0]
  def change
    create_table :attachments do |t|
      t.string :file_url
      t.integer :appointment_id

      t.timestamps
    end
  end
end
