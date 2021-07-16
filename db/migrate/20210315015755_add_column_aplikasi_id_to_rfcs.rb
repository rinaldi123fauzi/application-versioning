class AddColumnAplikasiIdToRfcs < ActiveRecord::Migration[5.2]
  def change
    add_reference :rfcs, :aplikasi, foreign_key: true
  end
end
