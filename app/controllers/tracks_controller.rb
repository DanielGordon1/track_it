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
      client = Soundcloud.new(access_token: current_user.token)
      sc_track = client.post('/tracks',
        track: {
          title: @track.name,
          asset_data: params[:file]
        }
      )

      @track.update(
        soundcloud_id: sc_track.id
      )

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
    if current_user.votes.where(user: current_user).exists?
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
