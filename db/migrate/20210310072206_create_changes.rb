class CreateChanges < ActiveRecord::Migration[5.2]
  def change
    create_table :changes do |t|
      t.date :tgl_release
      t.string :pemilik_proses
      t.string :versi_sourcecode

      t.timestamps
    end
  end
end
