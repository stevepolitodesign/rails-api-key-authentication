class AddPrivateApiKeyToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :private_api_key, :string
    add_index :users, :private_api_key, unique: true
  end
end