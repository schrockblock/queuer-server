class Api::V1::DaysController < Api::V1::ApiController
  inherit_resources

  belongs_to :sprint

  load_and_authorize_resource :user
  load_and_authorize_resource :through => :user
  skip_load_and_authorize_resource :only => [:index, :create, :update]

  def day_params
    params.require(:day).permit(:date)
  end
end
