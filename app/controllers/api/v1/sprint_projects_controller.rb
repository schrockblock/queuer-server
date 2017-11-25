class Api::V1::SprintProjectsController < Api::V1::ApiController
  inherit_resources

  belongs_to :sprint

  load_and_authorize_resource :user
  load_and_authorize_resource :through => :user
  skip_load_and_authorize_resource :only => [:index, :create, :update]

  def sprint_project_params
    params.require(:sprint_project).permit(:project_id)
  end
end
