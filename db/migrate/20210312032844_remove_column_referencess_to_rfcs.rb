class RemoveColumnReferencessToRfcs < ActiveRecord::Migration[5.2]
  def change
    remove_column :rfcs, :references, :string
  end
end
