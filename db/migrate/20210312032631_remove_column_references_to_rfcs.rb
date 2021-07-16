class RemoveColumnReferencesToRfcs < ActiveRecord::Migration[5.2]
  def change
    remove_column :rfcs, :references
  end
end
