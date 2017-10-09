class Api::V1::ProjectsController < Api::V1::ApiController
  inherit_resources

  belongs_to :user

  load_and_authorize_resource :user
  load_and_authorize_resource :through => :user
  skip_load_and_authorize_resource :only => [:index, :create, :update]

  def project_params
    params.require(:project).permit(:name, :color, :user_id)
  end
end
