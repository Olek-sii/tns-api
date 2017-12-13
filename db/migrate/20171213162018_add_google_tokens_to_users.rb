class AddGoogleTokensToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :google_tokens, :string
  end
end
