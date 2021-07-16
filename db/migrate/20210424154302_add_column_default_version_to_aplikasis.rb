class AddColumnDefaultVersionToAplikasis < ActiveRecord::Migration[5.2]
  def change
    add_column :aplikasis, :default_version, :string
  end
end
