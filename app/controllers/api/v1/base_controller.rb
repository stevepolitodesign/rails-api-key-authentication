class Api::V1::BaseController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  before_action :authenticate


  private

    def authenticate
      authenticate_user_with_token || handle_bad_authentication
    end

    # https://github.com/rails/rails/blob/83217025a171593547d1268651b446d3533e2019/actionpack/lib/action_controller/metal/http_authentication.rb#L352
    # https://www.pluralsight.com/blog/tutorials/token-based-authentication-rails
    def authenticate_user_with_token
      authenticate_with_http_token do |token, options|
        @user ||= User.find_by(private_api_key: token)
      end
    end

    def handle_bad_authentication
      render json: { message: "Bad credentials" }, status: :unauthorized
    end

    def handle_not_found
      render json: { message: "Record not found" }, status: :not_found
    end
end
