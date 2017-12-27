class Api::V1::UsersController < Api::V1::ApiController
  inherit_resources
  
  skip_load_and_authorize_resource :only => [:new, :create]
  load_and_authorize_resource
  
  before_action :permit_params

  def create
    @user = User.new(permit_params)
    if @user.save
      respond_with(@user) do |format|
        format.json { render json: @user.as_json(:include => [:api_key]), status: :created }
      end
    else
      render json: :nothing, status: :unprocessable_entity
    end
  end

  def permit_params
    params.require(:user).permit(:username, :password)
  end
end
