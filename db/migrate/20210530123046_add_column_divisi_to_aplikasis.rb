class AddColumnDivisiToAplikasis < ActiveRecord::Migration[5.2]
  def change
    add_column :aplikasis, :divisi, :string
  end
end
