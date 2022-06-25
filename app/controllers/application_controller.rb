class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?


  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_path
    when Customer
      customer_path(current_customer.id)
    end
  end

  def after_sign_out_path_for(resource)
    if resource == :admin
      new_customer_session_path
    elsif resource == :customer
      root_path
    end
  end

  private
  def configure_permitted_parameters
   devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, 
                                                      :last_name_kana, :first_name_kana, 
                                                      :post_code, :address, :phone_number])
  end
end
