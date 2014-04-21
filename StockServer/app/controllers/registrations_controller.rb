class RegistrationsController < Devise::RegistrationsController
  skip_before_filter :authenticate_user_from_token!

  # This method is to create the User
  # The following data will be created for the User once he/she registered
  # * +Profile+
  # * +WatchList+
  # * Welcome Email
  def create
    super
    if current_user
      #@profile = Profile.new()
      #@watch_list = WatchList.new()
      #@profile.users = current_user
      #@watch_list.users = current_user
      @new_user = current_user
      UserMailer.welcome_email(@new_user).deliver
      #@profile.save()
      #@watch_list.save()
    end
  end
end