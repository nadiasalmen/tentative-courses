# frozen_string_literal: true

require_relative '../lib/student'

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

  it 'has a delivery_mode' do
    expect(@student.delivery_mode).to eq('Individual')
  end

  it 'has a level' do
    expect(@student.level).to eq('Beginner')
  end

  it 'raises InvalidValue if delivery_mode is wrong' do
    expect { Student.new(delivery_mode: '', level: 'Beginner') }.to raise_error(Student::InvalidValue)
  end

  it 'raises InvalidValue if asked level is wrong' do
    expect { Student.new(delivery_mode: 'Individual', level: '') }.to raise_error(Student::InvalidValue)
  end
end
