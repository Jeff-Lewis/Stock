class UsersController < ApplicationController
  skip_before_filter :verified_request?, :authenticate_user_from_token!
  def index
    @users = User.all
    respond_to do |format|
      format.json { render :json => @users }
      format.xml  { render :xml => @users }
      format.html
    end
  end

  def destroy
    user = User.find(params[:id])
    if user.destroy
      redirect_to :controller => 'users', :action => 'index'
    end

  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:json, :xml, :html)
  end
end
