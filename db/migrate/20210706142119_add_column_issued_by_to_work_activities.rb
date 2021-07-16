class AddColumnIssuedByToWorkActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :work_activities, :issued_by, :string
  end
end
