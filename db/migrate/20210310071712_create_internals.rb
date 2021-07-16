class CreateInternals < ActiveRecord::Migration[5.2]
  def change
    create_table :internals do |t|
      t.date :tgl_testing
      t.string :penguji

      t.timestamps
    end
  end
end
