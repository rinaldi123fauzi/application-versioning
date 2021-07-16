class AddColumnIssuedByToMainResponsibilities < ActiveRecord::Migration[5.2]
  def change
    add_column :main_responsibilities, :issued_by, :string
  end
end
