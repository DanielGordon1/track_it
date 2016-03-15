class TrackersController < ApplicationController
  skip_before_action :authenticate_user!



  def show
    @tracker = user.find[:id]
  end

end



