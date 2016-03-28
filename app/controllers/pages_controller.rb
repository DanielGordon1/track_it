class PagesController < ApplicationController
   skip_before_action :authenticate_user!

  def home
      # votes are not part of track schema so first we need to count the amount of votes for each tracks
    @tracks = Track.select("tracks.*, count(votes.id) as votes_count").
      # joins the amount of votes to each track (take in account when the track as 0 votes)
      joins("LEFT OUTER JOIN votes ON votes.track_id = tracks.id").
      # tracks need to have a permalink
      where.not(soundcloud_permalink_url: nil).
      group("tracks.id").
      # the tracks are order by votes, if same amount of votes, by date of creation
      order("votes_count DESC, tracks.created_at DESC").
      # pagination for the scrolling
      page(params[:page]).per(3)
  end
end
