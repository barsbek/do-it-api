class UsersController < ApplicationController
  before_action :require_login!, except: [:login, :create, :logout]
  before_action :validate_login, only: [:login]

  # GET /users/1
  def show
    render json: public_params(current_user)
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: {
        user: public_params(@user),
        message: "Successfully signed up"
      }, status: :created, location: login_url
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if current_user.update(user_params)
      render json: public_params(current_user)
    else
      render json: current_user.errors, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by_email(params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      set_cookies(user)
      user_info = { id: user.id, name: user.name, email: user.email }
      render json: { message: "Logged in", user: user_info },
        location: user
    else
      render json: { message: "Incorrect email or password" },
        status: :unprocessable_entity
    end
  end

  def logout
    cookies.delete :auth_token
    render json: { message: "Logged out" },
      location: login_url
  end

  def set_cookies(user)
    cookies[:auth_token] = {
      value: User.encode_token( {user_id: user.id} ),
      expires: 1.day.from_now,
      domain: 'localhost'
    }
  end

  private
    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation, :avatar)
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
