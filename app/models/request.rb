class Request < ApplicationRecord
  belongs_to :user
  belongs_to :requestable, polymorphic: true

  # ArgumentError: You tried to define an enum named "method" on the model "Request",
  # but this will generate a class method "delete", which is already defined by Active Record.
  enum method: [:get, :post, :put, :patch, :delete], _suffix: true

  validates :method, :requestable, :user, presence: true

end
