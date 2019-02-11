class Api::V1::ProjectsController < Api::V1::ApiController
  inherit_resources

  load_and_authorize_resource through: :current_user

  def index
    projects = current_user.projects.order(created_at: :desc)

    render json: projects.as_json({ include: {} })
  end

  def project_params
    params.require(:project).permit(:name, :color).merge(user_id: current_user.id)
  end
end
