class AddTestIdToMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :test_id, :integer
  end
end
