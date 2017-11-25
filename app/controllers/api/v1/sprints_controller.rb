class Api::V1::SprintsController < Api::V1::ApiController
  inherit_resources

  load_and_authorize_resource :user
  load_and_authorize_resource :through => :user
  skip_load_and_authorize_resource :only => [:index, :create, :update]

  def sprint_params
    params.require(:sprint).permit(:name, :start_date, :end_date)
  end
end
