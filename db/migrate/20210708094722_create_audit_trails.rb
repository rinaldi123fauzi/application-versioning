class CreateAuditTrails < ActiveRecord::Migration[5.2]
  def change
    create_table :audit_trails do |t|
      t.string :user
      t.string :description
      t.string :controller
      t.string :action
      t.string :browser
      t.string :ip_address

      t.timestamps
    end
  end
end
