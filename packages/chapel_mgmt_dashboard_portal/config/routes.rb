ChapelMgmtDashboardPortal::Engine.routes.draw do
  root to: "dashboard#index"

  register_resource ::Profile, singular: true
  register_resource ::ChurchManagement::Chapel, singular: true
  register_resource ::ChurchManagement::Member
  register_resource ::ChurchManagement::Department
  register_resource ::ChurchManagement::DepartmentMembership
  register_resource ::ChurchManagement::Ministry
  register_resource ::ChurchManagement::MinistryMembership
  # register resources above.

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end

# mount our app
Rails.application.routes.draw do
  constraints Rodauth::Rails.authenticate(:user) do
    mount ChapelMgmtDashboardPortal::Engine, at: "/chapel_mgmt_dashboard"
  end
end
