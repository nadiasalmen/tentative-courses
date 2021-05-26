# frozen_string_literal: true

# this class represents a students manager
class StudentsManager
  attr_reader :students_grouped_by_timeslot_level_and_delivery_mode

  def initialize(attributes = {})
    @student_list = attributes[:student_list]
    @available_timeslots = attributes[:available_timeslots]
    @students_grouped_by_timeslot = group_students_by_timeslot
    @students_grouped_by_timeslot_level_and_delivery_mode = group_students_by_level_and_delivery_mode
  end

  private

  def find_student(student_id)
    @student_list.find do |student|
      student.student_id == student_id
    end
  end

  def group_students_by_timeslot
    @students_grouped_by_timeslot = {}
    @available_timeslots.collect(&:timeslot_id).each do |timeslot_id|
      @students_grouped_by_timeslot[timeslot_id] = []
      # faltaria primero ordenar student_list por id
      @student_list.each do |student|
        next unless student.student?

        student.timeslots.each do |student_timeslot|
          @students_grouped_by_timeslot[timeslot_id] << student.student_id if student_timeslot.timeslot_id == timeslot_id && student.allocated == false
        end
      end
    end
    @students_grouped_by_timeslot
  end

  def group_students_by_level_and_delivery_mode
    @students_grouped_by_timeslot_level_and_delivery_mode = {}
    @students_grouped_by_timeslot.each do |timeslot_id, student_ids_list|
      build_allocation_hash(timeslot_id)
      student_ids_list.each do |student_id|
        student = find_student(student_id)
        next unless student.allocated == false

        level = student.level
        delivery_mode = student.delivery_mode
        group_students_by_level(timeslot_id, level, delivery_mode, student_id)
      end
    end
    @students_grouped_by_timeslot_level_and_delivery_mode
  end

  def group_students_by_level(timeslot_id, level, delivery_mode, student_id)
    case level
    when 'Beginner' then group_students_by_delivery_mode(timeslot_id, level, delivery_mode, student_id)
    when 'Pre-Intermediate' then group_students_by_delivery_mode(timeslot_id, level, delivery_mode, student_id)
    when 'Intermediate' then group_students_by_delivery_mode(timeslot_id, level, delivery_mode, student_id)
    when 'Upper-Intermediate' then group_students_by_delivery_mode(timeslot_id, level, delivery_mode, student_id)
    when 'Advanced' then group_students_by_delivery_mode(timeslot_id, level, delivery_mode, student_id)
    end
  end

  def group_students_by_delivery_mode(timeslot_id, level, delivery_mode, student_id)
    case delivery_mode
    when 'Group'
      @students_grouped_by_timeslot_level_and_delivery_mode[timeslot_id][level]['students'][delivery_mode] << student_id
    when 'Individual'
      @students_grouped_by_timeslot_level_and_delivery_mode[timeslot_id][level]['students'][delivery_mode] << student_id
    end
  end

  def build_allocation_hash(timeslot_id)
    @students_grouped_by_timeslot_level_and_delivery_mode[timeslot_id] = {
      'Beginner' => {
        'students' => {
          'Group' => [],
          'Individual' => []
        },
        'weight' => 100
      },
      'Pre-Intermediate' => {
        'students' => {
          'Group' => [],
          'Individual' => []
        },
        'weight' => 200
      },
      'Intermediate' => {
        'students' => {
          'Group' => [],
          'Individual' => []
        },
        'weight' => 300
      },
      'Upper-Intermediate' => {
        'students' => {
          'Group' => [],
          'Individual' => []
        },
        'weight' => 400
      },
      'Advanced' => {
        'students' => {
          'Group' => [],
          'Individual' => []
        },
        'weight' => 500
      }
    }
  end

  def build_delivery_mode_hash
    {
      'Group' => [],
      'Individual' => []
    }
  end
end
