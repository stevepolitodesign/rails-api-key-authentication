class Api::V1::BaseController < ApplicationController
  before_action :authenticate_user_with_token

  private
    # https://github.com/rails/rails/blob/83217025a171593547d1268651b446d3533e2019/actionpack/lib/action_controller/metal/http_authentication.rb#L352
    # https://www.pluralsight.com/blog/tutorials/token-based-authentication-rails
    def authenticate_user_with_token
      authenticate_with_http_token do |token, options|
        User.find_by(private_api_key: token)
      end
    end
end
