class CommentsController < ApplicationController
  def create
    @track = Track.find(params[:track_id])
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.track = @track
    if @comment.save
      respond_to do |format|
        format.html { redirect_to track_path(@track) }
        format.js  # <-- will render `app/views/comments/create.js.erb`
      end
    else
      respond_to do |format|
        format.html { render 'tracks/show' }
        format.js  # <-- will render `app/views/comments/create.js.erb`
      end
    end
  end

  def show
    @comment = track.comments
  end


  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end
