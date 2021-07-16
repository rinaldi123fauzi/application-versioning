class AddColumnUatIdToChanges < ActiveRecord::Migration[5.2]
  def change
    add_reference :changes, :uat, foreign_key: true
  end
end
