## Add Encrypted Private API Key Column to Users Table

1. Install [lockbox](https://github.com/ankane/lockbox) and [blind_index](https://github.com/ankane/blind_index).

```
bundle add lockbox
bundle add blind_index
```

2. Configure Lockbox for test, development and production environment.

```
rails c 
Lockbox.generate_key
=> "123abc"
rails credentials:edit --environment=test
```

```yaml
lockbox:
  master_key: "123abc"
```

3. Create migration.

```
rails g migration add_private_api_key_ciphertext_to_users private_api_key_ciphertext:text
```

```ruby
# db/migrate/xxx_add_private_api_key_ciphertext_to_users.rb
class AddPrivateApiKeyToUsers < ActiveRecord::Migration[6.1]
  def change
    # encrypted data
    add_column :users, :private_api_key_ciphertext, :text
    
    # blind index
    add_column :users, :private_api_key_bidx, :string
    add_index :users, :private_api_key_bidx, unique: true
  end
end
```

```
rails db:migrate
```

4. Update User model.

```ruby
# app/models/user.rb
class User < ApplicationRecord
  encrypts :private_api_key
  blind_index :private_api_key
end
```

5. Set private api key via a callback.

```ruby
# app/models/user.rb
class User < ApplicationRecord
  encrypts :private_api_key
  blind_index :private_api_key

  before_create :set_private_api_key

  validates :private_api_key, uniqueness: true, allow_blank: true

  private

    def set_private_api_key
        self.private_api_key = SecureRandom.hex if self.private_api_key.nil?
    end
  end
end
```