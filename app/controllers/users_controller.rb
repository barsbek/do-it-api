class UsersController < ApplicationController
  before_action :require_login!, except: [:login, :create, :logout]
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :validate_login, only: [:login]
  
  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  def login
    user = User.find_by_email(params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      set_cookies(user)
      user_info = { id: user.id, name: user.name, email: user.email }
      render json: { message: "Logged in", user: user_info },
        status: :ok, location: user
    else
      render json: { message: "Incorrect email or password" },
        status: :unprocessable_entity
    end
  end

  def logout
    cookies.delete :auth_token
    render json: { message: "Logged out" }, status: :ok
  end

  def set_cookies(user)
    cookies[:auth_token] = {
      value: User.encode_token( {user_id: user.id} ),
      expires: 1.day.from_now,
      domain: 'localhost'
    }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation)
    end

    def validate_login
      if login_errors.any?
        return render json: login_errors, status: :unprocessable_entity
      end
    end

    def login_errors
      errors = {}
      [:email, :password].each do |param|
        errors[param] = ["can't be blank"] if params[:user][param].blank?
      end
      errors
    end
end
