# frozen_string_literal: true

require_relative '../lib/course.rb'
require_relative '../lib/course.rb'
require_relative '../lib/teacher.rb'
require_relative '../lib/timeslot.rb'

describe Course, :_course do
  describe '#initialize' do
    it 'takes a hash of attributes as a parameter' do
      attributes = {
        id: 1,
        teacher: teacher,
        delivery_mode: delivery_mode,
        level: level,
        timeslot: timeslot,
        students: students
      }
      course = Course.new(attributes)
      expect(course).to be_a(Course)
    end

    it 'receives the :teacher attribute, which is an instance of Teacher' do
      attributes = { teacher: Teacher.new({}) }
      course = Course.new(attributes)
      expect(course.instance_variable_get(:@teacher)).to be_a(Teacher)
    end

    it 'receives the :timeslot attribute, which is an instance of Timeslot' do
      attributes = { teacher: Timeslot.new({}) }
      course = Course.new(attributes)
      expect(course.instance_variable_get(:@timeslot)).to be_a(Timeslot)
    end
  end
end
