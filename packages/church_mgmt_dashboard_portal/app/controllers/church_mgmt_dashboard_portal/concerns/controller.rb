module ChurchMgmtDashboardPortal
  module Concerns
    module Controller
      extend ActiveSupport::Concern
      include Plutonium::Portal::Controller
      include Plutonium::Auth::Rodauth(:user)
      # add concerns above.

      included do
        before_action :ensure_user_profile_complete
        before_action :check_user_role_and_redirect
      end

      private

      def app_name = "Church Management Dashboard"

      def ensure_user_profile_complete
        if current_user.profile.blank?
          redirect_to resource_url_for(::Profile, action: :new)
        end
      end

      def check_user_role_and_redirect
        if current_user.church_admin?
          # Church Admins stay on this portal
        elsif current_user.chapel_leader?
          redirect_to "/chapel_mgmt_dashboard"
        elsif current_user.accountant?
          # redirect_to accounts_dashboard_path
        end
      end
    end
  end
end
