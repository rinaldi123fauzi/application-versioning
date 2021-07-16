class CreatePriorities < ActiveRecord::Migration[5.2]
  def change
    create_table :priorities do |t|
      t.string :nama
      t.string :deskripsi

      t.timestamps
    end
  end
end
