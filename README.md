## Add Encrypted Private API Key Column to Users Table

1. Install [lockbox](https://github.com/ankane/lockbox) and [blind_index](https://github.com/ankane/blind_index).

```
bundle add lockbox
bundle add blind_index
```

2. Configure Lockbox for test, development and production environment. You'll want to run the following code for each environment.

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

> **What's Going On Here?**
>
> - We use Lockbox as a means to encrypt the private api key because the key is essentially as sensitive as a username and password. If the database were every compromised, the keys would not be stored in plain text. This gem also allows us to reference the column as `private_api_key` and not `private_api_key_ciphertext`
> - We use Blink Index as a means to query against the key, as well as ensure its value is unique. We need Blink Index because the column is encrypted.
> - We add a validation ensuring the key is unique. This is because the key will be used to identify a user.
> - We use [SecureRandom](https://ruby-doc.org/stdlib-3.0.2/libdoc/securerandom/rdoc/SecureRandom.html) to generate a unique value for the key. This is necessary to make it difficult for someone to guess another user's key.