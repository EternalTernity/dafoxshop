class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :current_cart

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  def current_cart
    if user_signed_in?
      if current_user.cart.nil?
        cart = Cart.create(user: current_user)
      else
        cart = current_user.cart
      end
      session[:cart_id] = cart.id
      cart
    else
      cart = Cart.find(session[:cart_id]) if session[:cart_id]
      if cart.nil?
        cart ||= Cart.create
        session[:cart_id] = cart.id
      end
      cart
    end
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :last_name, :email, :phone_number, :password, :avatar) }
    devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit( :email, :password, :remember_me) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:first_name, :last_name, :email, :password, :current_password, :avatar) }
  end
end
