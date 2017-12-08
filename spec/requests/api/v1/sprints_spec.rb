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
      other_user = create :user, username: 'other'
      project = create :project, user: user
      task = create :task, project: project
      sprint = create :sprint, user: user
      create :sprint, user: other_user
      day = create :day, sprint: sprint
      create :day_task, day: day, task: task
      create :sprint_project, sprint: sprint, project: project

      get(api_v1_sprints_url, {}, authorization_headers(user))

      expect(response).to have_http_status :ok
      expect(json.count).to eq 1
    end

    it 'is unauthorized when no user' do
      user = create :user
      create :sprint, user: user

      get(api_v1_sprints_url, {}, accept_headers)

      expect(response).to have_http_status :forbidden
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
