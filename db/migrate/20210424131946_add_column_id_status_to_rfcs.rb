class AddColumnIdStatusToRfcs < ActiveRecord::Migration[5.2]
  def change
    add_column :rfcs, :id_status, :integer
  end
end
