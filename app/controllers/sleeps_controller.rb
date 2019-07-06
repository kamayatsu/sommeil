class SleepsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_ids, only: [:show]

  def new
    @user = User.find(current_user.id)
    @sleep = Sleep.new
  end

  def create
    @sleep = Sleep.new(create_params)
    if @sleep.save
      redirect_to root_path      
    else
      flash[:alert] = "睡眠時間を入力してください。もしくは、前日の睡眠時間が登録されていません。先に前日の睡眠時間を登録してください。"
      redirect_to new_user_sleep_path
    end
  end

  def show
    @sleep = Sleep.find(params[:id])
  end

  def destroy
    sleep = Sleep.find(params[:id])
    sleep.destroy if sleep.user_id == current_user.id
    redirect_to root_path
  end

  def edit
    @user = User.find(current_user.id)
    @sleep = Sleep.find(params[:id])
    @sleep.slept_time = @sleep.slept_time.strftime("%H:%M")
    @sleep.wakeup_time = @sleep.wakeup_time.strftime("%H:%M")
  end

  def update
    @sleep = Sleep.find(params[:id])
    @sleep.update(create_params) if @sleep.user_id == current_user.id
    redirect_to root_path
  end

  private
  def create_params
    params.require(:sleep).permit(:slept_time, :wakeup_time, :date).merge(user_id: current_user.id)
  end

  def correct_ids
    path = request.fullpath.split('/')[4].to_i
    unless current_user.sleeps.ids.include?(path)
      redirect_to root_path
    end
  end
end
