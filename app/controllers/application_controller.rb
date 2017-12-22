class ApplicationController < ActionController::API
  include ActionController::Cookies
  
  def current_user
    @current_user ||= if cookies[:auth_token].present?
      payload = User.decode_token(cookies[:auth_token])
      User.find(payload[:user_id]) if payload
    end
  end  

  protected

  def authentication_request!
    if current_user.nil?
      return render json: { errors: 'Not authenticated' }, status: :unauthorized
    end
  end
end
