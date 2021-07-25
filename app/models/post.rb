class Post < ApplicationRecord
  belongs_to :user
  has_many :requests, as: :requestable

  validates :title, :body, presence: true
end
