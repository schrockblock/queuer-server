class Api::V1::SprintsController < Api::V1::ApiController
  inherit_resources

  load_and_authorize_resource :user

  def index
    render json: Sprint.where(user_id: current_user.id)
  end

  def sprint_params
    params.require(:sprint).permit(:name, :start_date, :end_date).merge(user_id: current_user.id)
  end
end
