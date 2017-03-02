class ApiController < ApplicationController
  # When the request is sent through another site, it comes without the token, it raises an exception.
  # But the tokes are sent only on form submissions. The tokens are not sent for clicking links, entering URLs in the address bar, sending requests through JavaScript.
  # There's no token there, and Rails will reject the API request, even though it's coming from an authenticated admin.

  # Ignoring CSRF For API requests(Only in case when not dealing with highly confidential or important information.)
  skip_before_action :verify_authenticity_token

  private
  def authenticated?
    authenticate_or_request_with_http_basic do |email, password|
      (@current_user = User.where(email: email, password: password).first) ? true : false
    end
  end
end
