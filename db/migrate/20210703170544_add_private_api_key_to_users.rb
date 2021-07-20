class AddPrivateApiKeyToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :private_api_key_ciphertext, :string, null: false
    add_index :users, :private_api_key_ciphertext, unique: true
  end
end