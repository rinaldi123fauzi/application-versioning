class AddColumnTahunToWorkActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :work_activities, :tahun, :integer
  end
end
