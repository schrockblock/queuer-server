class Api::V1::SessionsController < Api::V1::ApiController
  inherit_resources
  load_and_authorize_resource
  skip_load_and_authorize_resource :only => [:new, :create]

  def create
    @user = User.where(:username => session_params[:username]).first
    if @user
      if @user.authenticate(session_params[:password])
        @current_user = @user
        respond_with(@user) do |format|
          format.json { render :json => @user.as_json(:include => [:api_key]) }
        end
      else
        render(:json => { :errors => "Invalid email or password" }.to_json, :status => 401)
      end
    else
      render(:json => { :errors => "Username not found, please try again" }.to_json, :status => 401)
    end
  end

  private 

  def session_params
    params.permit :username, :password
  end
end
