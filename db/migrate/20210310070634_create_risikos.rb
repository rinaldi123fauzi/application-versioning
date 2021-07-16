class CreateRisikos < ActiveRecord::Migration[5.2]
  def change
    create_table :risikos do |t|
      t.string :nama
      t.string :deskripsi

      t.timestamps
    end
  end
end
