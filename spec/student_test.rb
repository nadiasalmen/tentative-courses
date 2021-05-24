# frozen_string_literal: true

require_relative '../lib/student'

VALID_DELIVERY_MODES = %w[Individual Group].freeze
VALID_LEVELS = %w[Beginner Pre-Intermediate Intermediate Upper-Intermediate Advanced].freeze

shared_context 'student instances' do
  before do
    @student = Student.new(
      delivery_mode: 'Individual',
      level: 'Beginner'
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

  it 'raises InvalidValue if delivery_mode is wrong' do
    expect { Student.new(delivery_mode: '', level: 'Beginner') }.to raise_error(Student::InvalidValue)
  end

  it 'raises InvalidValue if asked level is wrong' do
    expect { Student.new(delivery_mode: 'Individual', level: '') }.to raise_error(Student::InvalidValue)
  end
end
