class CreateApiTests < ActiveRecord::Migration[5.2]
  def change
    create_table :api_tests do |t|
      t.string :nama
      t.string :alamat

      t.timestamps
    end
  end
end
