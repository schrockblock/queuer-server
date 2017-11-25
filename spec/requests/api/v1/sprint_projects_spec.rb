require 'rails_helper'

describe 'Sprint Project requests' do
  describe 'POST /api/v1/sprints/:id/sprint_projects' do
    it 'creates a day and returns' do
      user = create :user
      project = create :project, user: user
      sprint = create :sprint, user: user

      post(api_v1_sprint_sprint_projects_url(sprint), valid_sprint_proj_params(project), 
           authorization_headers(user))

      expect(response).to have_http_status :created
    end
  end

  describe 'GET /api/v1/sprints/:id/sprint_projects' do
    it 'gets sprint for the user' do
      user = create :user
      project = create :project, user: user
      sprint = create :sprint, user: user
      create :sprint_project, sprint: sprint, project: project

      get(api_v1_sprint_sprint_projects_url(sprint), {}, authorization_headers(user))

      expect(response).to have_http_status :ok
    end
  end
end

def valid_sprint_proj_params(project)
  {
    sprint_project: {
      project_id: project.id
    }
  }.to_json
end
