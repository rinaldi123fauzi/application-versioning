class AddColumnStatusToPenyelesaians < ActiveRecord::Migration[5.2]
  def change
    add_column :penyelesaians, :status, :string
  end
end
