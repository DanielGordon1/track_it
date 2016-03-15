class TrackersController < ApplicationController

  def show
    @tracker = user.find[:id]
  end

end


  