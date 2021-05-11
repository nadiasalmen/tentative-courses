# frozen_string_literal: true

# this class represents a student
class Student
  class InvalidValue < StandardError; end

  attr_reader :delivery_mode, :level

  DELIVERY_MODES = %w[Individual Group].freeze
  LEVELS = %w[Beginner Pre-Intermediate Intermediate Upper-Intermediate Advanced].freeze

  def initialize(attributes = {})
    raise InvalidValue unless DELIVERY_MODES.include?(attributes[:delivery_mode])
    raise InvalidValue unless LEVELS.include?(attributes[:level])

    @delivery_mode = attributes[:delivery_mode]
    @level = attributes[:level]
    @timeslots = []
    @allocated = false
  end
end
