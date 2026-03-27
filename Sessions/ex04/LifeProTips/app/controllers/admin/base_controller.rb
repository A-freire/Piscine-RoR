module Admin
  class BaseController < ApplicationController
    before_action :require_admin

    private

    def require_admin
      return if signed_in? && logged_in_user.admin?

      redirect_to root_path, alert: "Administrator rights are required."
    end
  end
end
