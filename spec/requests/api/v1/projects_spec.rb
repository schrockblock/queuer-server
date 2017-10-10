require 'rails_helper'

describe 'Project requests' do
  describe 'POST /api/v1/user/:id/projects' do
    it 'creates a project and returns' do
      user = create :user

      new_project_attributes = {
        project: {
          name: 'Queuer',
          color: 1
        }
      }.to_json

      post(api_v1_user_projects_url(user), new_project_attributes, authorization_headers(user))

      expect(response).to have_http_status :created
      # expect(json['api_key']).not_to be_nil
    end
  end
end
