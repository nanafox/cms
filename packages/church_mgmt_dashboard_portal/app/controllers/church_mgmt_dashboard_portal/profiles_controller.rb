class ChurchMgmtDashboardPortal::ProfilesController < ::ProfilesController
  include ChurchMgmtDashboardPortal::Concerns::Controller

  skip_before_action :ensure_user_profile_complete, only: [ :new, :create ]
  skip_before_action :check_user_role_and_redirect, only: [ :new, :create ]
end
