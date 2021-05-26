# frozen_string_literal: true

# this class represents a course
class Course
  attr_reader :students, :teacher, :delivery_mode, :level, :timeslot

  def initialize(attributes = {})
    @teacher = attributes[:teacher]
    @delivery_mode = attributes[:delivery_mode]
    @level = attributes[:level]
    @timeslot = attributes[:timeslot]
    @students = attributes[:students]
  end

  def to_s
    str = <<DESC
    Day: #{@timeslot.day} - Time: #{@timeslot.time}
    Level: #{@delivery_mode} - Delivery Mode: #{@delivery_mode}
    Teacher: #{@teacher.teacher_id}
    Students: #{@students.collect(&:student_id)}
DESC
    str
  end
end
