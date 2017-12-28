class AddCheckNumberToMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :check_number, :integer
  end
end
