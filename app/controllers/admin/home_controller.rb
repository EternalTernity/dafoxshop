class Admin::HomeController < AdminController
  before_action :authenticate_user!
  before_action :is_admin?
  def index
  end

  def is_admin?
    unless current_user.admin?
      redirect_to root_path
    end
  end
end
