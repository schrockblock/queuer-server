class Api::V1::UsersController < Api::V1::ApiController
  inherit_resources
  load_and_authorize_resource
  skip_load_and_authorize_resource :only => [:new, :create]

  def create
    @user = User.new(params[:user])
    @user.save

    respond_with(@user) do |format|
      format.json { render :json =>  @user.as_json(:include => [:api_key]) }
    end
  end
end
