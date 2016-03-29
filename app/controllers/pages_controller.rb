class PagesController < ApplicationController
   skip_before_action :authenticate_user!

  def home
    @tracks = Track.hot.page(params[:page]).per(3)
  end
end
