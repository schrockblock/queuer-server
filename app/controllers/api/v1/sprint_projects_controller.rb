class Api::V1::SprintProjectsController < Api::V1::ApiController
  inherit_resources

  load_and_authorize_resource :user

  def index
    sprint = Sprint.find(params[:sprint_id])

    render json: sprint.sprint_projects.as_json, status: :ok
  end

  def create
    create_params = sprint_project_params
    create_params['sprint_id'] = sprint.id

    object = SprintProject.create(create_params)

    render json: object.as_json, status: :created
  end

  def sprint_project_params
    params.require(:sprint_project).permit(:project_id)
  end

  def sprint
    if params[:sprint_id].present?
      Sprint.find(params[:sprint_id])
    elsif params[:sprint_project_id]
      SprintProject.find(params[:sprint_project_id]).sprint
    end
  end
end
