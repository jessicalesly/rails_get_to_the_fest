class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    match_path # defining redirect result route (omniauth controller)
  end

  def default_url_options
    { host: ENV["HOST"] || "localhost:3000" }
  end
end
