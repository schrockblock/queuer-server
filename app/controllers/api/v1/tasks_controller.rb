class Api::V1::TasksController < Api::V1::ApiController
  inherit_resources

  belongs_to :project

  load_and_authorize_resource :project
  load_and_authorize_resource :through => :project
  skip_load_and_authorize_resource :only => [:index, :create, :update, :delete]

  def task_params
    params.require(:task).permit(:name, :order, :finished, :project_id)
  end
end
