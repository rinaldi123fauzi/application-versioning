class CreateUats < ActiveRecord::Migration[5.2]
  def change
    create_table :uats do |t|
      t.string :no_testing
      t.date :tgl_testing
      t.string :penguji

      t.timestamps
    end
  end
end
