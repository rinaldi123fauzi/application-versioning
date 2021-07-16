class AddColumnStatusToUats < ActiveRecord::Migration[5.2]
  def change
    add_column :uats, :status, :string
  end
end
