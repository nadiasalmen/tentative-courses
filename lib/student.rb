# frozen_string_literal: true

# this class represents a student
class Student
  def initialize(delivery_mode, level)
    @delivery_mode = delivery_mode
    @level = level
    @timeslots = []
    @allocated = false
  end
end
