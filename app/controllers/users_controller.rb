class UsersController < ApplicationController
  skip_before_action :set_user_and_albums_with_info, only: %i[index new create edit update destroy search]
  def index
    @users = User.all
    @user = User.new
  end

  def search
    @users = if params[:username].present?
              User.search_by_username(params[:username])

            else
              User.all
            end
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          'search_results',
          partial: 'users/search_results',
          locals: { users:@users }
        )
      end
    end
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path, notice: 'User was successfully created.'
    else
      @users = User.all
      render :index
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :phone, :email, :photo, :street, :suite, :city, :zipcode, :lat, :lng)
  end
end
