class AddColumnRfcIdToChanges < ActiveRecord::Migration[5.2]
  def change
    add_reference :changes, :rfc, foreign_key: true
  end
end
