class AddFollowupCommentsToAppointment < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :followup_comments, :string
  end
end
