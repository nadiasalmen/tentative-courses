# frozen_string_literal: true

# this class represents a student
class Teacher
  attr_reader :teacher_id, :timeslots

  def initialize(attributes = {})
    @teacher_id = attributes[:teacher_id]
    @timeslots = attributes[:timeslots]
  end

  def teacher?
    true
  end
end
# agregar test de timeslots
