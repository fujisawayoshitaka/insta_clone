class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
     UserMailer.user_mail(@user).deliver
     redirect_to user_path(@user.id), notice: 'User was successfully created.'
    else
      render 'new'
    end
  end

  def show

  end

  def edit

  end

  def update

    if @user.update(user_params)
      redirect_to user_path, notice: "プロフィールを編集しました！"
    else
      render :edit
    end
  end
  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :image,:image_cache,
                                 :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
