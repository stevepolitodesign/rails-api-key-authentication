class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_create :set_private_api_key

  validates :private_api_key, uniqueness: true 

  private

      def set_private_api_key
        self.private_api_key = SecureRandom.hex if self.private_api_key.nil?
    end
end
