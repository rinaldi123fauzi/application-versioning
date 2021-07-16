class AddColumnNoTestingToChanges < ActiveRecord::Migration[5.2]
  def change
    add_column :changes, :no_testing, :string
  end
end
