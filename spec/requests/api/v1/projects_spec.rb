require 'rails_helper'

describe 'Project requests' do
  describe 'POST /api/v1/projects' do
    it 'creates a project and returns' do
      user = create :user

      new_project_attributes = {
        project: {
          name: 'Queuer',
          color: 1
        }
      }.to_json

      post(api_v1_projects_url, new_project_attributes, authorization_headers(user))

      expect(response).to have_http_status :created

      project = Project.last

      expect(project.user).to eq user
    end
  end

  describe 'GET /projects' do
    it 'returns user projects' do
      user = create :user
      project = create :project, user: user
      another_project = create :project, user: user
      other_user = create :user, username: "other"
      other_project = create :project, user: other_user

      get(api_v1_projects_url, {}, authorization_headers(user))

      expect(response).to have_http_status :ok
      expect(json.count).to eq 2
    end

    it 'is unauthorized when no user' do
      user = create :user
      project = create :project, user: user

      get(api_v1_projects_url, {}, accept_headers)

      expect(response).to have_http_status :unauthorized
    end
  end
end
