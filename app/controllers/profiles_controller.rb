class ProfilesController < ApplicationController

 def show
    @profile = current_user
    @tracks = current_user.tracks
    @comments = current_user.comments
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
    params.require(:user).permit(:first_name, :last_name, :username)
  end
end