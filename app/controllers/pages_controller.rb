class PagesController < ApplicationController
   skip_before_action :authenticate_user!

  def home
    @tracks = Track.select("tracks.*, count(votes.id) as votes_count").
      joins("LEFT OUTER JOIN votes ON votes.track_id = tracks.id").
      where.not(soundcloud_permalink_url: nil).
      group("tracks.id").
      order("votes_count DESC, tracks.created_at DESC").
      page(params[:page]).per(3)
  end
end
