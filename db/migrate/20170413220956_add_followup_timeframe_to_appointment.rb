class AddFollowupTimeframeToAppointment < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :followup_timeframe, :string
  end
end
