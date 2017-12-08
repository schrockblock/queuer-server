class Api::V1::TasksController < Api::V1::ApiController
  inherit_resources

  belongs_to :project

  load_and_authorize_resource :project

  def task_params
    params.require(:task).permit(:name, :order, :finished, :project_id)
  end
end
