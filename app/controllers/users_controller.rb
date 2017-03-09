require 'jsonwebtoken'
class UsersController < ApplicationController
  before_action :authenticate_admin, except: [:login]
  before_action :set_user, only: [:show, :update, :destroy]


  def login
    user = User.find_by(email: params[:email].to_s.downcase)

    if user && user.password == params[:password]
        auth_token = JsonWebToken.encode({api_key: user.api_key})
        render json: {auth_token: auth_token}, status: :ok
    else
      render json: {error: 'Invalid username / password'}, status: :unauthorized
    end
  end

  # GET /v1/users
  def index
    @users = User.all

    render json: @users
  end

  # GET /v1/users/1
  def show
    render json: @user
  end

  # POST /v1/users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/users/1
  def destroy
    @user.destroy
  end

  private

    # User functionalities can be done by admin
    def authenticate_admin
      user = User.where("email = ? AND password = ?", params[:user_email], params[:user_password]).first
      if user.api_key != 'RF70F4yyqXEzdMgklqKQLAtt'
        render json:{'error': 'You are credntials are authorized to access user'}, status: :unprocessable_entity
      end
    rescue
      render json:{'error': 'You are not admin to access user'}, status: :unprocessable_entity
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :email)
    end
end
