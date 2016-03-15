class TrackersController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    @tracker = User.find(params[:id])
  end

end



