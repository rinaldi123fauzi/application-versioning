class CreateRfcs < ActiveRecord::Migration[5.2]
  def change
    create_table :rfcs do |t|
      t.string :no_registrasi_perubahan
      t.string :versi_aplikasi
      t.string :uraian_perubahan
      t.string :link
      t.string :tanggal

      t.timestamps
    end
  end
end
