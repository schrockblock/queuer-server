class Api::V1::SprintProjectTasksController < Api::V1::ApiController
  inherit_resources

  belongs_to :sprint_project

  load_and_authorize_resource :user

  def sprint_project_task_params
    params.require(:sprint_project_task).permit(:task_id)
  end
end
