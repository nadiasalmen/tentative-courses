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

  it 'has a valid delivery_mode' do
    expect(VALID_DELIVERY_MODES).to include(@student.delivery_mode)
  end

  it 'has a valid level' do
    expect(VALID_LEVELS).to include(@student.level)
  end

  it 'has a valid timeslot' do
    expect(TIMESLOTS).to include(*@student.timeslots)
  end

  it 'raises InvalidValue if delivery_mode is wrong' do
    expect { Student.new(delivery_mode: '', level: 'Beginner') }.to raise_error(Student::InvalidValue)
  end

  it 'raises InvalidValue if level is wrong' do
    expect { Student.new(delivery_mode: 'Individual', level: '') }.to raise_error(Student::InvalidValue)
  end
end
