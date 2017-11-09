class Admin::BaseController < ActionController::Base
  before_action :authenticate_admin_admin!
  layout "admin/base"
end
