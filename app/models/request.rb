class Request < ApplicationRecord
  belongs_to :user
  belongs_to :record, polymorphic: true
end
