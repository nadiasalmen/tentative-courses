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

  def valid_teacher?
    @teacher.teacher?
  end

  def valid_student_list?
    @students.each(&student?)
  end

  def valid_timeslot?
    @timeslot.timeslot?
  end
end
