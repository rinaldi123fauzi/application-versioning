class CreatePenyelesaians < ActiveRecord::Migration[5.2]
  def change
    create_table :penyelesaians do |t|
      t.string :kode_penyelesaian
      t.date :tgl_selesai
      t.string :durasi
      t.string :pic

      t.timestamps
    end
  end
end
