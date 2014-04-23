class Api::V1::RegistrationsController < Devise::RegistrationsController
  skip_before_filter :verified_request?, :authenticate_user_from_token!

  respond_to :json

  def create
    build_resource(sign_up_params)

    resource_saved = resource.save
    yield resource if block_given?
    if resource_saved
      sign_up(resource_name, resource)

      sign_in resource

      UserMailer.welcome_email(current_user).deliver
      @result = true
      @message = "Registered successfully"
      @data = current_user.to_json.html_safe()

      profile = Profile.new()
      profile.user = current_user
      profile.username = params[:username]
      profile.save()
    else
      clean_up_passwords resource

      @result = false
      @message = "Email already exists"
      @data = {}
    end

    render :partial => "layouts/show.json"
  end
end