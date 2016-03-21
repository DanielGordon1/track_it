class TracksController < ApplicationController

  before_action :find_track, only: [:show, :upvote, :downvote, :destroy]


  def show
    @comment = Comment.new
  end

  def new
    @track = current_user.tracks.new
  end

  def create
    @track = current_user.tracks.new(track_params)
    if @track.save
      redirect_to track_path(@track)
    else
      render :new
    end
  end

  def destroy
    @track.destroy
    redirect_to current_user
  end

  def upvote
    if current_user.votes.where(user: current_user)
       @track.votes.where(user: current_user).first.destroy
       redirect_to root_path(anchor: "hot-tracks")
    else 
       @track.votes.where(user: current_user).first_or_create
       redirect_to root_path(anchor: "hot-tracks")
   end
 end

private

def find_track
  @track = Track.find(params[:id])
end

def track_params
  params.require(:track).permit(:name, :genre, :version)
end

end
