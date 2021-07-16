class CreateAplikasis < ActiveRecord::Migration[5.2]
  def change
    create_table :aplikasis do |t|
      t.string :id_aplikasi
      t.string :kode
      t.string :nama_aplikasi
      t.string :deskripsi
      t.string :pemilik_proses

      t.timestamps
    end
  end
end
