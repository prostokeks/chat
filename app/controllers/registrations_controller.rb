class RegistrationsController < Devise::RegistrationsController
  private
  def after_sign_up_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource_or_scope)
    request.referrer
  end
end