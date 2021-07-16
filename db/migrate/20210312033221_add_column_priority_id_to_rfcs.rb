class AddColumnPriorityIdToRfcs < ActiveRecord::Migration[5.2]
  def change
    add_reference :rfcs, :priority, foreign_key: true
  end
end
