class AddColumnBulanToWorkActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :work_activities, :bulan, :string
  end
end
