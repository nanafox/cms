module ChapelMgmtDashboardPortal
  module Concerns
    module Controller
      extend ActiveSupport::Concern
      include Plutonium::Portal::Controller
      include Plutonium::Auth::Rodauth(:user)
      # add concerns above.
      private

        def current_chapel
          @current_chapel ||= current_user&.chapel
        end
    end
  end
end
