class TracksController < ApplicationController
  respond_to :js, only: [:detail, :upvote, :index]

  skip_before_action :authenticate_user!, only: [:index, :fresh, :trending, :show, :detail]
  before_action :find_track, only: [:show, :upvote, :downvote, :detail]

  def fresh
    @tracks = Track.fresh.page(params[:page]).per(3)
  end

  def trending
    @tracks = Track.trending.page(params[:page]).per(3)
  end

  def show
    @comment = Comment.new
  end

  def new
    @track = current_user.tracks.new
  end

  def index
    case params[:tab]
    when "fresh"
      @tracks = Track.fresh
    when "trending"
      @tracks = Track.trending
    else # hot
      @tracks = Track.hot
    end

    @tracks = @tracks.page(params[:page]).per(3)
  end

  def detail
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
        soundcloud_id: sc_track.id,
        # soundcloud_created_at: sc_track.created_at,
        soundcloud_user_id: sc_track.user_id,
        soundcloud_duration: sc_track.duration,
        # soundcloud_tag_list: sc_track.tag_list,
        # soundcloud_genre: sc_track.genre,
        # soundcloud_description: sc_track.description,
        soundcloud_title: sc_track.title,
        soundcloud_track_type: sc_track.track_type,
        # soundcloud_license: sc_track.license,
        soundcloud_user_playback_count: sc_track.user_playback_count,
        soundcloud_permalink_url: sc_track.permalink_url,
        soundcloud_stream_url: sc_track.stream_url,
        soundcloud_download_url: sc_track.download_url,
        soundcloud_waveform_url: sc_track.waveform_url,
        soundcloud_playback_count: sc_track.playback_count,
        soundcloud_download_count: sc_track.download_count,
        soundcloud_favoritings_count: sc_track.favoritings_count,
        soundcloud_comment_count: sc_track.comment_count,
        soundcloud_uri: sc_track.uri,
        soundcloud_artwork_url: sc_track.artwork_url,
        # soundcloud_downloadable: sc_track.downloadable,
        soundcloud_user_favorite: sc_track.user_favorite,
      )

      redirect_to track_path(@track)
    else
      render :new
    end
  end

  def destroy
    @track = current_user.tracks.find(params[:id])
    @track.destroy

    respond_to do |format|
      format.html { redirect_to profile_path }
      format.js  # <-- will render `app/views/tracks/destroy.js.erb`
    end
  end

  def upvote
    # you can upvote only once
    if !@track.votes.where(user: current_user).exists?
      @track.votes.where(user: current_user).first_or_create
    else
    # you can take your upvote back
      current_user.votes.where(user: current_user)
      @track.votes.where(user: current_user).first.destroy
    end
  end

  private

  def find_track
    @track = Track.find(params[:id])
    update_artwork
  end

  def track_params
    params.require(:track).permit(:name, :genre, :version)
  end

  def update_artwork
    if user_signed_in?
      client = Soundcloud.new(access_token: current_user.token)
    else
      client = Soundcloud.new(
        client_id:     ENV['SOUNDCLOUD_ID'],
        client_secret: ENV['SOUNDCLOUD_SECRET']
      )
    end

    sc_track = client.get("/tracks/#{@track.soundcloud_id}")

    if sc_track.artwork_url
      @track.update(soundcloud_artwork_url: sc_track.artwork_url)
    else
      @track.update(soundcloud_artwork_url: sc_track.user.avatar_url)
    end
  end
end
