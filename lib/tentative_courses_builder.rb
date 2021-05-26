# frozen_string_literal: true

require_relative 'course.rb'
require_relative 'students_manager.rb'
require_relative 'teachers_manager.rb'

# this class represents a tentative courses builder
class TentativeCoursesBuilder
  attr_reader :tentative_courses, :available_timeslots, :unavailable_timeslots

  def initialize(attributes = {})
    @student_list = attributes[:student_list]
    @teacher_list = attributes[:teacher_list]
    timeslot_list = attributes[:timeslot_list]
    @available_timeslots = TeachersManager.new(teacher_list: @teacher_list, timeslot_list: timeslot_list).available_timeslots
    @unavailable_timeslots = TeachersManager.new(teacher_list: @teacher_list, timeslot_list: timeslot_list).unavailable_timeslots
    @students_grouped_by_timeslot_level_and_delivery_mode = StudentsManager.new({student_list: @student_list, available_timeslots: @available_timeslots}).students_grouped_by_timeslot_level_and_delivery_mode
    @tentative_courses = build_tentantive_courses
  end

  def build_tentantive_courses
    @tentative_courses = []
    @students_grouped_by_timeslot_level_and_delivery_mode.each do |timeslot_id, level_groups_hash|
      next unless find_timeslot(timeslot_id).available_teachers.count.positive?

      updated_level_groups_hash = delete_already_allocated_students_from_level_groups_hash(level_groups_hash)
      prioritized_level_array = prioritize_level_groups(updated_level_groups_hash)
      prioritized_level_array.each do |prioritized_level|
        find_timeslot(timeslot_id).available_teachers.each do |teacher_id|
          next unless prioritized_level[1]['students']['Group'].count.positive?

          level = prioritized_level[0]
          student_list = []
          prioritized_level[1]['students']['Group'].take(6).each do |student_id|
            student = find_student(student_id)
            student.allocate
            student_list << student
          end
          @students_grouped_by_timeslot_level_and_delivery_mode[timeslot_id][level]['students']['Group'] = prioritized_level[1]['students']['Group'] - prioritized_level[1]['students']['Group'].take(6)
          timeslot = find_timeslot(timeslot_id)
          teacher = find_teacher(teacher_id)
          update_teacher_timeslot_status(teacher_id, timeslot_id) unless teacher_id.nil?
          @tentative_courses << Course.new(teacher: teacher, delivery_mode: 'Group', students: student_list, level: level, timeslot: timeslot)
        end
      end
      next unless find_timeslot(timeslot_id).available_teachers.count.positive?

      prioritized_level_array.each do |prioritized_level|
        find_timeslot(timeslot_id).available_teachers.each do |teacher_id|
          next unless prioritized_level[1]['students']['Individual'].count.positive?

          level = prioritized_level[0]
          student_list = []
          student_id = prioritized_level[1]['students']['Individual'].first
          student = find_student(student_id)
          student.allocate
          student_list << student
          @students_grouped_by_timeslot_level_and_delivery_mode[timeslot_id][level]['students']['Individual'] = prioritized_level[1]['students']['Individual'] - student_list.collect(&:student_id)
          timeslot = find_timeslot(timeslot_id)
          teacher = find_teacher(teacher_id)
          update_teacher_timeslot_status(teacher_id, timeslot_id) unless teacher_id.nil?
          @tentative_courses << Course.new(teacher: teacher, delivery_mode: 'Individual', students: student_list, level: level, timeslot: timeslot)
        end
      end
    end
    @tentative_courses
  end

  def unallocated_students
    @student_list.reject{ |e| e.allocated == true }
  end

  private

  # Update Teachers

  def update_teacher_timeslot_status(teacher_id, timeslot_id)
    find_teacher_timeslot(find_teacher(teacher_id).timeslots, timeslot_id)[:allocated] = true
    find_timeslot(timeslot_id).available_teachers -= find_timeslot(timeslot_id).available_teachers.select{ |e| e == teacher_id }
  end

  def find_timeslot(timeslot_id)
    @available_timeslots.find do |timeslot|
      timeslot.timeslot_id == timeslot_id
    end
  end

  def find_teacher(teacher_id)
    @teacher_list.find do |teacher|
      teacher.teacher_id == teacher_id
    end
  end

  def find_teacher_timeslot(teacher_timeslots, timeslot_id)
    teacher_timeslots.find do |teacher_timeslot|
      teacher_timeslot[:timeslot].timeslot_id == timeslot_id
    end
  end

  # Update Students

  def find_student(student_id)
    @student_list.find do |student|
      student.student_id == student_id
    end
  end

  def delete_already_allocated_students_from_level_groups_hash(level_groups_hash)
    level_groups_hash.each do |_level, level_hash|
      level_hash['students'].each do |_delivery_mode, delivery_mode_list|
        delivery_mode_list.delete_if do |student_id|
          student = find_student(student_id)
          true if student.allocated == true
        end
      end
    end
  end

  def prioritize_level_groups(level_groups_hash)
    prioritized_levels = level_groups_hash.sort_by do |_level, level_hash|
      -level_hash['students']['Group'].take(6).count * level_hash['weight'].to_i
    end
    prioritized_levels
  end
end
