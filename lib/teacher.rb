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

# timeslot es un array de hashes: {timeslot_id: timeslot_id, allocated: false}
# agregar a tests!
