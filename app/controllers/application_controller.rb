class ApplicationController < ActionController::API
  include ActionController::Cookies
  
  def current_user
    @current_user ||= if cookies[:auth_token].present?
      payload = User.decode_token(cookies[:auth_token])
      User.find(payload[:user_id]) if payload
    end
  end

  protected

  def require_login!
    if current_user.nil?
      return render json: { message: "Not authenticated" },
        status: :unauthorized, location: login_url
    end
  end

  def public_params(user)
    user.as_json(only: [:id, :name, :email], methods: :avatar_thumb)
  end
end
