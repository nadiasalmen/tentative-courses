# frozen_string_literal: true

require_relative '../lib/teacher'
require_relative '../lib/timeslot'

TIMESLOTS = Timeslot.build_unique_timeslots

shared_context 'teacher instances' do
  before do
    @teacher = Teacher.new(
      teacher_id: 0,
      timeslots: [{ timeslot: TIMESLOTS[0], allocated: false },
                  { timeslot: TIMESLOTS[1], allocated: false },
                  { timeslot: TIMESLOTS[2], allocated: false }]
    )
  end
end

describe Teacher do
  include_context 'teacher instances'

  it 'has a valid timeslot' do
    expect(@teacher.timeslots[0][:timeslot].day).to eq('Monday')
    expect(@teacher.timeslots[0][:timeslot].time).to eq(9)
  end
end
