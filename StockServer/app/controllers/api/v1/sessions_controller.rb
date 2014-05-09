class Api::V1::SessionsController < Devise::SessionsController
  skip_before_filter :verified_request?
  skip_before_filter :authenticate_user_from_token!, :except => [:create, :destroy]

  respond_to :json

  def create
    if current_user.nil?
      resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    end

    @result = true
    @message = "Logged in"
    current_user.ensure_authentication_token
    current_user.save()
    @data = current_user.to_json().html_safe

    render :partial => "layouts/show.json"
  end

  def destroy
    resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    current_user.update_column(:authentication_token, nil)

    sign_out(resource)

    @result = true
    @message = "Logged out"
    @data = {}

    render :partial => "layouts/show.json"
  end

  def failure
    @result = false
    @message = "Login Failed"

    render :partial => "layouts/show.json"
  end
end