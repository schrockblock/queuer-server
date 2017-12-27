class Api::V1::ProjectsController < Api::V1::ApiController
  inherit_resources

  load_and_authorize_resource through: :current_user

  def project_params
    params.require(:project).permit(:name, :color).merge(user_id: current_user.id)
  end
end
