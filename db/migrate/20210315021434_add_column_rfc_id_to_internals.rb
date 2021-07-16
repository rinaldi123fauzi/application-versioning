class AddColumnRfcIdToInternals < ActiveRecord::Migration[5.2]
  def change
    add_reference :internals, :rfc, foreign_key: true
  end
end
