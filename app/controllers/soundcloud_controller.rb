class SoundcloudController < ApplicationController
  skip_before_action :authenticate_user!

  def auth
    redirect_to client.authorize_url
  end

  def callback
    credentials = client.exchange_token(code: params[:code])
    infos = client.get('/me')
    auth = { credentials: credentials, infos: infos }
    user = User.find_for_soundcloud_oauth(auth)

    if user.persisted?
      sign_in_and_redirect user, event: :authentication
      flash[:notice] = "Successfully signed in with Soundcloud" if is_navigational_format?
    else
      flash[:alert] = "Unable to sign in with Soundcloud. Please try again"
      redirect_to new_user_session_url
    end
  end

  private

  def client
    @client ||= Soundcloud.new(
      client_id:     ENV['SOUNDCLOUD_ID'],
      client_secret: ENV['SOUNDCLOUD_SECRET'],
      redirect_uri:  soundcloud_callback_url
    )
  end
end
