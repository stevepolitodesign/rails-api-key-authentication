class Request < ApplicationRecord
  belongs_to :user
  belongs_to :requestable, polymorphic: true
end
