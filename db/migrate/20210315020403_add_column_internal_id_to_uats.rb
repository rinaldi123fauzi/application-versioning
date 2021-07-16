class AddColumnInternalIdToUats < ActiveRecord::Migration[5.2]
  def change
    add_reference :uats, :internal, foreign_key: true
  end
end
