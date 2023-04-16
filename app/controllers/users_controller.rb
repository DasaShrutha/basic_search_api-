class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :destroy]

	def index
    @users = User.all
    render json: @users
  end

  def new
    @user = User.new
    render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render json: @user.errors.as_json
    end
  end

  def search
    string = params[:word]
    @users = User.search_for_word(string)
    render json: @users, status: :ok 
  end

  private

  def find_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone_number)
  end
end
