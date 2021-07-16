class CreateStaffs < ActiveRecord::Migration[5.2]
  def change
    create_table :staffs do |t|
      t.string :nama
      t.string :jabatan
      t.string :satuan_kerja
      t.string :status_kepegawaian

      t.timestamps
    end
  end
end
