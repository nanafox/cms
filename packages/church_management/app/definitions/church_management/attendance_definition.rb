class ChurchManagement::AttendanceDefinition < ChurchManagement::ResourceDefinition
  new_page_title "Mark attendance"
  new_page_description "Select the member to mark attendance for and proceed"

  edit_page_title "Update attendance"
  edit_page_description "Adjust the date or status of the attendance"

  display :status, formatter: ->(value) { value.titlecase }

  field :date, as: :date, value: Date.today, required: true,
    hint: "Select the date mark attendance for."
  field :status,
    choices: ChurchManagement::Attendance.statuses.keys.to_h { |status|
      [status.to_sym, status.titlecase]
    }, hint: "Was the member Present or Absent?", required: true
end
