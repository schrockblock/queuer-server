class Api::V1::SprintProjectsController < Api::V1::ApiController
  inherit_resources

  load_and_authorize_resource :user

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
