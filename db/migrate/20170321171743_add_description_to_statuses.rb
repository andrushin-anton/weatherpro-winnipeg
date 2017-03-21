class AddDescriptionToStatuses < ActiveRecord::Migration[5.0]
  def change
    add_column :statuses, :description, :string
  end
end
