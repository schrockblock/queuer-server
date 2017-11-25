require 'rails_helper'

describe 'Day requests' do
  describe 'POST /api/v1/sprints/:id/days' do
    it 'creates a day and returns' do
      user = create :user
      sprint = create :sprint, user: user

      post(api_v1_sprint_days_url(sprint), valid_day_params, authorization_headers(user))

      expect(response).to have_http_status :created
    end
  end

  describe 'GET /api/v1/sprints/:id/days' do
    it 'gets sprint for the user' do
      user = create :user
      sprint = create :sprint, user: user
      create_list :day, 3, sprint: sprint

      get(api_v1_sprint_days_url(sprint), {}, authorization_headers(user))

      expect(response).to have_http_status :ok
    end
  end
end

def valid_day_params
  {
    day: {
      date: 2.days.from_now
    }
  }.to_json
end
