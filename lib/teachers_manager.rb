# frozen_string_literal: true

# this class represents a teachers manager
class TeachersManager
  attr_reader :available_timeslots

  def initialize(attributes = {})
    @teacher_list = attributes[:teacher_list]
    @timeslot_list = attributes[:timeslot_list]
    @available_timeslots = assign_teacher_to_timeslot
  end

  def unavailable_timeslots
    @timeslot_list - @available_timeslots
  end

  private

  def assign_teacher_to_timeslot
    @available_timeslots = []
    @timeslot_list.each do |timeslot|
      next unless timeslot.timeslot?

      @teacher_list.each do |teacher|
        next unless teacher.teacher?

        teacher.timeslots.each do |teacher_timeslot|
          if teacher_timeslot[:timeslot].timeslot_id == timeslot.timeslot_id && teacher_timeslot[:allocated] == false
            timeslot.available_teachers << teacher.teacher_id
          end
        end
      end
      @available_timeslots << timeslot unless timeslot.available_teachers.count.zero?
    end
    @available_timeslots
  end
end
