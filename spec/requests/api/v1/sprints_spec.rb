require 'rails_helper'

describe 'Sprint requests' do
  describe 'POST /api/v1/sprints' do
    it 'creates a sprint and returns' do
      post(api_v1_sprints_url, valid_sprint_params, authorization_headers)

      expect(response).to have_http_status :created
    end
  end

  describe 'GET /api/v1/sprints' do
    it 'gets sprint for the user' do
      user = create :user
      project = create :project, user: user
      task = create :task, project: project
      sprint = create :sprint, user: user
      day = create :day, sprint: sprint
      create :day_task, day: day, task: task
      create :sprint_project, sprint: sprint, project: project

      get(api_v1_sprints_url, {}, authorization_headers(user))

      expect(response).to have_http_status :ok
    end
  end
end

def valid_sprint_params
  {
    sprint: {
      start_date: 2.days.from_now
    }
  }.to_json
end
