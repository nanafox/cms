module ChurchManagement
  module Attendances
    class MarkAttendance < ::ResourceInteraction
      presents label: "Mark Attendance", icon: Phlex::TablerIcons::BookmarkPlus
      attribute :resource

      attribute :date
      attribute :status

      field :date, as: :date, value: Date.today(), required: true,
                   hint: "Select the date mark attendance for."
      field :status, choices: ChurchManagement::Attendance
                       .statuses.keys.to_h { |status|
                       [status.to_sym, status.titlecase]
                     }, hint: "Was the member Present or Absent?",
                     required: true

      validates :date, :status, presence: true

      def execute
        attendance = resource
          .attendances.build(status:, date:, recorder: current_user)

        if attendance.save
          succeed(resource)
            .with_message("Attendance marked successfully.")
        else
          failed(attendance.errors)
        end
      end
    end
  end
end
