class AddColumnStatusUraianToRfcs < ActiveRecord::Migration[5.2]
  def change
    add_column :rfcs, :status_uraian, :string
  end
end
