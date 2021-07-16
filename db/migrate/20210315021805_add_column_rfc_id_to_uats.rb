class AddColumnRfcIdToUats < ActiveRecord::Migration[5.2]
  def change
    add_reference :uats, :rfc, foreign_key: true
  end
end
