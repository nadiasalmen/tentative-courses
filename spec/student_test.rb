# frozen_string_literal: true

require_relative '../lib/student'
require_relative '../lib/timeslot'

VALID_DELIVERY_MODES = %w[Individual Group].freeze
VALID_LEVELS = %w[Beginner Pre-Intermediate Intermediate Upper-Intermediate Advanced].freeze
TIMESLOTS = Timeslot.build_unique_timeslots

shared_context 'student instances' do
  before do
    @student = Student.new(
      student_id: 0,
      delivery_mode: 'Individual',
      level: 'Beginner',
      timeslots: TIMESLOTS.sample(rand(1..5))
    )
  end
end

describe Student do
  include_context 'student instances'

  it 'should have a valid delivery mode' do
    expect(@student).to respond_to :delivery_mode
    expect(@student.delivery_mode).to be_a String
    expect(VALID_DELIVERY_MODES).to include(@student.delivery_mode)
  end

  it 'should have a valid level' do
    expect(@student).to respond_to :level
    expect(@student.level).to be_a String
    expect(VALID_LEVELS).to include(@student.level)
  end

  it 'has valid timeslots' do
    expect(@student).to respond_to :timeslots
    expect(@student.timeslots).to all(be_a Timeslot)
    expect(TIMESLOTS).to include(*@student.timeslots)
  end

  it 'raises InvalidValue if delivery_mode is wrong' do
    expect { Student.new(delivery_mode: '', level: 'Beginner') }.to raise_error(Student::InvalidValue)
  end

  it 'raises InvalidValue if level is wrong' do
    expect { Student.new(delivery_mode: 'Individual', level: '') }.to raise_error(Student::InvalidValue)
  end
end
