module DeviseConcerns
  extend ActiveSupport::Concern

  included do
    before_action :configure_permitted_parameters , if: :devise_controller?
  end

  # Whitelist
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name ])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end

  # current_user null object replaced with guest_user
  def current_user
    super || guest_user
  end

  def guest_user
    OpenStruct.new(
      name: "Guest User", 
      first_name: "Guest", 
      last_name: "User", 
      email: "guest@test.com"
    )
  end

end