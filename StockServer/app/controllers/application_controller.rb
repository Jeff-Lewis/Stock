class ApplicationController < ActionController::Base
  @@fail_msg_incorrect_request = "operation is incorrect."
  @@fail_msg_unauthenticate = "operation is not authenticated."

  #protect_from_forgery

  after_filter :set_csrf_header
  before_filter :verified_request?, :authenticate_user_from_token!

  def set_csrf_header
    response.headers['X-CSRF-Token'] = form_authenticity_token
  end

  def verified_request?
    if protect_against_forgery? && !request.get?
      if (!params[request_forgery_protection_token].nil? || !request.headers['X-CSRF-Token'].nil?)
        @result = (form_authenticity_token == params[request_forgery_protection_token] ||
            form_authenticity_token == request.headers['X-CSRF-Token'])
      else
        @result = false
      end

      if @result == false
        @message = @@fail_msg_incorrect_request
        @data = {}
        render :partial => "layouts/show.json"
      else
        true
      end
    else
      super()
    end
  end

  def authenticate_user_from_token!
    user_email = params[:user_email].presence
    user_token = params[:user_token].presence
    user = user_email && User.find_by_email(user_email)

    if user && Devise.secure_compare(user.authentication_token, user_token)
      sign_in user, store: false
    end
  end
end
