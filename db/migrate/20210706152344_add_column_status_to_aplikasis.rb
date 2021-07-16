class AddColumnStatusToAplikasis < ActiveRecord::Migration[5.2]
  def change
    add_column :aplikasis, :status, :string
  end
end
