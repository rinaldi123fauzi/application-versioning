class AddColumnInternalIdToChanges < ActiveRecord::Migration[5.2]
  def change
    add_reference :changes, :internal, foreign_key: true
  end
end
