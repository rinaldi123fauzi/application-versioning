class AddColumnPenyelesaianIdToUats < ActiveRecord::Migration[5.2]
  def change
    add_reference :uats, :penyelesaian, foreign_key: true
  end
end
