class PagesController < ApplicationController
   skip_before_action :authenticate_user!

  def home
    @tracks = Track.all
  end
end
