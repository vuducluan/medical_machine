class Admin::SessionsController < Devise::SessionsController
  layout "admin/base"

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || admin_root_path
  end

  def after_sign_out_path_for(resource_or_scope)
    new_admin_admin_session_path()
  end
end
