class ChurchManagement::MembersController < ChurchManagement::ResourceController
  private

  def resource_params
    @my_resource_params ||= begin
      input_params = super
      input_params[:creator] = current_user
      input_params
    end
  end
end
