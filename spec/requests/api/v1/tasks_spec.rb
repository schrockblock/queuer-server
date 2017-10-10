require 'rails_helper'

describe 'Task requests' do
  describe 'POST /api/v1/users/:id/projects/:id/tasks' do
    it 'creates a task and returns JSON' do
      user = create :user
      project = create :project, user_id: user.id

      new_task_attributes = {
        task: {
          name: 'Be awesome',
          finished: false,
          order: 1
        }
      }.to_json

      post(api_v1_user_project_tasks_url(user, project), new_task_attributes, authorization_headers(user))

      expect(response).to have_http_status :created
      # expect(json['api_key']).not_to be_nil
    end
  end
end
