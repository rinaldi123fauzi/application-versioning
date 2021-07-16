class CreateMainResponsibilities < ActiveRecord::Migration[5.2]
  def change
    create_table :main_responsibilities do |t|
      t.references :staff, foreign_key: true, on_delete: :cascade
      t.string :tanggung_jawab_utama
      t.string :aktivitas
      t.string :output
      t.string :periode
      t.integer :frekuensi
      t.integer :menit

      t.timestamps
    end
  end
end
