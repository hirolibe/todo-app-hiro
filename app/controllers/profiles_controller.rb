class ProfilesController < ApplicationController
  before_action :set_profile, only: [:edit, :update]
  before_action :authenticate_user!

  def show
    @profile = current_user.profile
  end

  def edit
  end

  def update
    @profile.assign_attributes(profile_params)
    if @profile.save
      redirect_to profile_path, notice: 'プロフィールを更新しました'
    else
      flash.now[:error] = 'プロフィールを更新できませんでした'
      render :edit
    end
  end

  private
  def set_profile
    @profile = current_user.prepare_profile
  end

  def profile_params
    params.require(:profile).permit(:nickname, :avatar)
  end
end