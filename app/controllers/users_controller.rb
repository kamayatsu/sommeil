class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:show]
  def index
    user = User.find(current_user.id)
    @sleeps = user.sleeps.order('date DESC').includes(:user).limit(7).reverse
    @sleep = user.sleeps.last
  end

  def show
    @user = User.find(params[:id])
    @sleeps = @user.sleeps.order('date DESC').includes(:user).limit(14).reverse
  end

  private
  def correct_user
    path = request.fullpath.split('/')[2].to_i
    if current_user.id != path
      redirect_to root_path
    end
  end
end
