# Handles incoming user form-based HTTP authentication requests
# @author Chris Loftus
class SessionsController < ApplicationController
  skip_before_action :login_required

  # GET /session/new
  def new
  end

  # POST /session
  def create
    user_detail =
        UserDetail.authenticate(params[:login], params[:password])
    if user_detail
      self.current_user = user_detail
      uri = session[:original_uri]
      session[:original_uri] = nil
      redirect_to(uri || home_url)
    else
      flash[:error] = 'Invalid user/password combination'
      redirect_to new_session_url
    end
  end

  #DELETE /session
  def destroy
    session[:user_id] = nil
    redirect_to home_url
  end

end