class ProfilesController < ApplicationController

 def show
    @profile = current_user
    @tracks = current_user.tracks.order(created_at: :desc)
    @upvoted_tracks = Track.joins(:votes).where(votes: { user_id: current_user.id }).select("tracks.*, MAX(votes.created_at) as vote_created_at").order("vote_created_at DESC").group("tracks.id")
    @commented_tracks = Track.joins(:comments).where(comments: { user_id: current_user.id }).select("tracks.*, MAX(comments.created_at) as comment_created_at").order("comment_created_at DESC").group("tracks.id")
  end

  def edit
    @profile
  end

  def update
    if @profile.update(user_params)
      redirect_to user_path
    else
      render action: 'edit'
    end
  end

  def destroy
    @profile.destroy
    redirect_to users_path
  end

  private

  def set_profile
    @profile = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :photo, :photo_cache)
  end
end
