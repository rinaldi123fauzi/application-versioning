class AddColumnStatusToRfcs < ActiveRecord::Migration[5.2]
  def change
    add_column :rfcs, :status, :string
  end
end
