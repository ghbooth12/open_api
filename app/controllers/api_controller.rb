class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  private
  def authenticated?
    authenticate_or_request_with_http_basic do |email, password|
      (@current_user = User.where(email: email, password: password).first) ? true : false
    end
  end
end
