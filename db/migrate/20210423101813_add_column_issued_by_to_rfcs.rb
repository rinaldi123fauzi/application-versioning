class AddColumnIssuedByToRfcs < ActiveRecord::Migration[5.2]
  def change
    add_column :rfcs, :issued_by, :string
  end
end
