class AddColumnRisikoIdToRfcs < ActiveRecord::Migration[5.2]
  def change
    add_reference :rfcs, :risiko, foreign_key: true
  end
end
