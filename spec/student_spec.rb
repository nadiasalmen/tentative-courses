# frozen_string_literal: true

require_relative '../lib/student'
require_relative '../lib/timeslot'

VALID_DELIVERY_MODES = %w[Individual Group].freeze
VALID_LEVELS = %w[Beginner Pre-Intermediate Intermediate Upper-Intermediate Advanced].freeze

shared_context 'student instances' do
  before do
    # Create students:
    @student_list = []
    student_count = 1

    # Group && Beginner
    30.times do
      @student_list << Student.new(
        {
          student_id: student_count,
          delivery_mode: 'Group',
          level: 'Beginner',
          timeslots: TIMESLOTS.sample(rand(1..5))
        }
      )
      student_count += 1
    end

    # Group && Pre-Intermediate
    30.times do
      @student_list << Student.new(
        {
          student_id: student_count,
          delivery_mode: 'Group',
          level: 'Pre-Intermediate',
          timeslots: TIMESLOTS.sample(rand(1..5))
        }
      )
      student_count += 1
    end

    # Group && Intermediate
    30.times do
      @student_list << Student.new(
        {
          student_id: student_count,
          delivery_mode: 'Group',
          level: 'Intermediate',
          timeslots: TIMESLOTS.sample(rand(1..5))
        }
      )
      student_count += 1
    end

    # Group && Upper-Intermediate
    30.times do
      @student_list << Student.new(
        {
          student_id: student_count,
          delivery_mode: 'Group',
          level: 'Upper-Intermediate',
          timeslots: TIMESLOTS.sample(rand(1..5))
        }
      )
      student_count += 1
    end

    # Group && Advanced
    30.times do
      @student_list << Student.new(
        {
          student_id: student_count,
          delivery_mode: 'Group',
          level: 'Advanced',
          timeslots: TIMESLOTS.sample(rand(1..5))
        }
      )
      student_count += 1
    end

    # Individual && Beginner
    30.times do
      @student_list << Student.new(
        {
          student_id: student_count,
          delivery_mode: 'Individual',
          level: 'Beginner',
          timeslots: TIMESLOTS.sample(rand(1..5))
        }
      )
      student_count += 1
    end

    # Individual && Pre-Intermediate
    30.times do
      @student_list << Student.new(
        {
          student_id: student_count,
          delivery_mode: 'Individual',
          level: 'Pre-Intermediate',
          timeslots: TIMESLOTS.sample(rand(1..5))
        }
      )
      student_count += 1
    end

    # Individual && Intermediate
    30.times do
      @student_list << Student.new(
        {
          student_id: student_count,
          delivery_mode: 'Individual',
          level: 'Intermediate',
          timeslots: TIMESLOTS.sample(rand(1..5))
        }
      )
      student_count += 1
    end

    # Individual && Upper-Intermediate
    30.times do
      @student_list << Student.new(
        {
          student_id: student_count,
          delivery_mode: 'Individual',
          level: 'Upper-Intermediate',
          timeslots: TIMESLOTS.sample(rand(1..5))
        }
      )
      student_count += 1
    end

    # Individual && Advanced
    30.times do
      @student_list << Student.new(
        {
          student_id: student_count,
          delivery_mode: 'Individual',
          level: 'Advanced',
          timeslots: TIMESLOTS.sample(rand(1..5))
        }
      )
      student_count += 1
    end
  end
end

describe Student do
  include_context 'student instances'

  it 'should have a delivery mode' do
    expect(@student_list).to all(respond_to :delivery_mode)
  end

  it 'its delivery mode should be one of: Group or Individual' do
    @student_list.each do |student|
      expect(student.delivery_mode).to be_a String
      expect(VALID_DELIVERY_MODES).to include(student.delivery_mode)
    end
  end

  it 'should have a level' do
    expect(@student_list).to all(respond_to :level)
  end

  it 'its level should be one of: Beginner, Pre-Intermediate, Intermediate, Upper-Intermediate or Advanced' do
    @student_list.each do |student|
      expect(student.level).to be_a String
      expect(VALID_LEVELS).to include(student.level)
    end
  end

  it 'should have timeslots' do
    expect(@student_list).to all(respond_to :timeslots)
  end

  it 'each of its timeslots should be a Timeslot' do
    @student_list.each do |student|
      expect(student.timeslots).to all(be_a Timeslot)
      expect(TIMESLOTS).to include(*student.timeslots)
    end
  end

  it 'raises InvalidValue if delivery_mode is wrong' do
    expect { Student.new(delivery_mode: '', level: 'Beginner') }.to raise_error(Student::InvalidValue)
  end

  it 'raises InvalidValue if level is wrong' do
    expect { Student.new(delivery_mode: 'Individual', level: '') }.to raise_error(Student::InvalidValue)
  end
end

describe '#allocate' do
  include_context 'student instances'

  it 'should mark a student as allocated' do
    @student_list.each do |student|
      expect(student.allocated).to be false
      student.allocate
      expect(student.allocated).to be true
    end
  end
end

describe '#student?' do
  include_context 'student instances'

  it 'should let us check if its class is Student' do
    @student_list.each do |student|
      expect(student).to respond_to(:student?)
      expect(student.student?).to eq(true)
    end
  end
end
