class AddColumnPriorityIdToRfc < ActiveRecord::Migration[5.2]
  def change
    add_column :rfcs, :references, :priorities
  end
end
