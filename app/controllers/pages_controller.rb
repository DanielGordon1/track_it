class PagesController < ApplicationController
   skip_before_action :authenticate_user!

  def home
    @tracks = Track.where.not(soundcloud_permalink_url: nil)
     # the track permalink can't be nil
  end
end
