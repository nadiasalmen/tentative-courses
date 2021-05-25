# frozen_string_literal: true

# this class represents a student
class Student
  class InvalidValue < StandardError; end

  attr_reader :student_id, :delivery_mode, :level, :timeslots, :allocated

  VALID_DELIVERY_MODES = %w[Individual Group].freeze
  VALID_LEVELS = %w[Beginner Pre-Intermediate Intermediate Upper-Intermediate Advanced].freeze

  def initialize(attributes = {})
    unless VALID_DELIVERY_MODES.include?(attributes[:delivery_mode])
      raise InvalidValue, "#{attributes[:delivery_mode]} is not a valid delivery mode."
    end
    raise InvalidValue, "#{attributes[:level]} is not a valid level." unless VALID_LEVELS.include?(attributes[:level])

    @student_id = attributes[:student_id]
    @delivery_mode = attributes[:delivery_mode]
    @level = attributes[:level]
    @timeslots = attributes[:timeslots]
    @allocated = false
  end

  def student?
    true
  end

  def allocate
    @allocated = true
  end
end
