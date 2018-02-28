class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def spotify
    user = User.find_for_spotify_oauth(request.env['omniauth.auth']) #method defined in devise
    if user.persisted?
      sign_in_and_redirect user, event: :authentication # redirect to the result page (application controller)
    else
      redirect_to root_path
    end
  end
end


    #   sign_in_and_redirect user, event: :authentication
    #   set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
    # else
    #   session['devise.facebook_data'] = request.env['omniauth.auth']
    #   redirect_to new_user_registration_url
    # end
