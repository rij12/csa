# Top-level class for common controller code
# @author Chris Loftus
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Make is_admin? a helper method available to view templates
  helper_method :is_admin?

  protected

  # Is the caller an admin user? Currently everyone is!
  # @return true if admin user else false
  def is_admin?
    true
  end
end
