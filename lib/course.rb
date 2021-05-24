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

  def validate_teacher
    @teacher.teacher?
  end

  def validate_student
    @students.each(&student?)
  end

  def validate_timeslot
    @timeslot.timeslot?
  end
end
