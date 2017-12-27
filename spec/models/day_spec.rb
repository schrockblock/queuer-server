require 'rails_helper'

describe 'Day' do

  describe 'points' do
    it 'calculates points correctly' do
      day = create :day
      task = create :task 
      finished_task = create :task, finished: true
      day_task = create :day_task, task: task, day: day
      day_finished_task = create :day_task, task: finished_task, day: day

      expect(day.points).to eq 2
      expect(day.finished_points).to eq 1
    end
  end

end
