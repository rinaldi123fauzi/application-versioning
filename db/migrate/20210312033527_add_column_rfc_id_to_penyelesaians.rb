class AddColumnRfcIdToPenyelesaians < ActiveRecord::Migration[5.2]
  def change
    add_reference :penyelesaians, :rfc, foreign_key: true
  end
end
