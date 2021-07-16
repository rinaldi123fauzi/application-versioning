class AddColumnPenyelesaianIdToInternals < ActiveRecord::Migration[5.2]
  def change
    add_reference :internals, :penyelesaian, foreign_key: true
  end
end
