class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    match_path_url # defining redirect result route (omniauth controller)
  end
end
