class Api::V1::DaysController < Api::V1::ApiController
  inherit_resources

  belongs_to :sprint

  load_and_authorize_resource :sprint
  load_and_authorize_resource :through => :sprint

  def day_params
    params.require(:day).permit(:date)
  end
end
