class TrackersController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    @tracker = User.find(params[:id])
    @tracks_tracker = @tracker.tracks.order(created_at: :desc)
    @upvoted_tracks_tracker = Track.joins(:votes).where(votes: { user_id: @tracker.id }).select("tracks.*, MAX(votes.created_at) as vote_created_at").order("vote_created_at DESC").group("tracks.id")
    @commented_tracks_tracker = Track.joins(:comments).where(comments: { user_id: @tracker.id }).select("tracks.*, MAX(comments.created_at) as comment_created_at").order("comment_created_at DESC").group("tracks.id")
  end

end