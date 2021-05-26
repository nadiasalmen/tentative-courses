# frozen_string_literal: true

require_relative '../lib/teacher'
require_relative '../lib/timeslot'

TIMESLOTS = Timeslot.build_unique_timeslots

shared_context 'teacher instances' do
  before do
    # Create teachers:
    @teacher_list = []
    teacher_count = 1

    10.times do
      timeslots = []
      rand(1..25).times do
        timeslots << { timeslot: TIMESLOTS.sample, allocated: false }
      end
      @teacher_list << Teacher.new(teacher_id: teacher_count, timeslots: timeslots.uniq)
      teacher_count += 1
    end
  end
end

describe Teacher do
  include_context 'teacher instances'

  it 'should have timeslots' do
    expect(@teacher_list).to all(respond_to :timeslots)
  end
  it 'each of its timeslot should be a Hash' do
    @teacher_list.each do |teacher|
      expect(teacher.timeslots).to all(be_a Hash)
    end
  end
  it 'each of its timeslots should have a timeslot attribute of class Timeslot' do
    @teacher_list.each do |teacher|
      expect(teacher.timeslots[0][:timeslot]).to be_a Timeslot
    end
  end
end

describe '#teacher?' do
  include_context 'teacher instances'

  it 'should let us check if its class is Teacher' do
    @teacher_list.each do |teacher|
      expect(teacher).to respond_to(:teacher?)
      expect(teacher.teacher?).to eq(true)
    end
  end
end
