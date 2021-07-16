class CreateWorkActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :work_activities do |t|
      t.references :staff, foreign_key: true
      t.date :periode_waktu
      t.string :aktivitas
      t.string :waktu_per_aktivitas

      t.timestamps
    end
  end
end
