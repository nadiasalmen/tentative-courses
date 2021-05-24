# frozen_string_literal: true

# this clas represet timeslots
class Timeslot
  class InvalidValue < StandardError; end

  VALID_DAYS = %w[Monday Tuesday Wednesday Thursday Friday].freeze
  VALID_TIMES = (9..19).to_a

  attr_reader :timeslot_id
  attr_accessor :available_teachers

  def initialize(attributes = {})
    raise InvalidValue unless VALID_DAYS.include?(attributes[:day])
    raise InvalidValue unless VALID_TIMES.include?(attributes[:time])

    @timeslot_id = attributes[:timeslot_id]
    @day = attributes[:day]
    @time = attributes[:time]
    @available_teachers = []
  end

  def self.build_unique_timeslots
    timeslots = []
    timeslot_id = 1
    VALID_DAYS.each do |day|
      VALID_TIMES.each do |time|
        timeslots << Timeslot.new(timeslot_id: timeslot_id, day: day, time: time)
        timeslot_id += 1
      end
    end
    timeslots
  end

  def valid_timeslot?(timeslot)
    Timeslot.build_unique_timeslots.include?(timeslot)
  end

  def timeslot?
    true
  end
end
