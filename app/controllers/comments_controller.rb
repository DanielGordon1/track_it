class CommentsController < ApplicationController
  def create
    @track = Track.find(params[:track_id])
    @comment = Comment.new(comment_params)
    @comment.track = @track
    if @comment.save
      redirect_to track_path(@tracks)
    else
      render 'tracks/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end
