class AddColumnCategoryIdToRfcs < ActiveRecord::Migration[5.2]
  def change
    add_reference :rfcs, :category, foreign_key: true
  end
end
