class AddColumnAplikasiIdToChanges < ActiveRecord::Migration[5.2]
  def change
    add_reference :changes, :aplikasi, foreign_key: true
  end
end
