# frozen_string_literal: true

require_relative 'lib/student.rb'
require_relative 'lib/teacher.rb'
require_relative 'lib/timeslot.rb'
require_relative 'lib/tentative_course.rb'

# Timeslots:
timeslot_list = Timeslot.build_unique_timeslots

# Create teachers:
teacher_list = []
teacher_count = 1

10.times do
  timeslots = []
  rand(1..25).times do
    timeslots << { timeslot: timeslot_list.sample, allocated: false }
  end
  teacher_list << Teacher.new(teacher_id: teacher_count, timeslots: timeslots.uniq)
  teacher_count += 1
end

# Create students:

student_list = []
student_count = 1

# Group && Beginner
30.times do
  student_list << Student.new({
                                student_id: student_count,
                                delivery_mode: 'Group',
                                level: 'Beginner',
                                timeslots: timeslot_list.sample(rand(1..5))
                              })
  student_count += 1
end

# Group && Pre-Intermediate
30.times do
  student_list << Student.new({
                                student_id: student_count,
                                delivery_mode: 'Group',
                                level: 'Pre-Intermediate',
                                timeslots: timeslot_list.sample(rand(1..5))
                              })
  student_count += 1
end

# Group && Intermediate
30.times do
  student_list << Student.new({
                                student_id: student_count,
                                delivery_mode: 'Group',
                                level: 'Intermediate',
                                timeslots: timeslot_list.sample(rand(1..5))
                              })
  student_count += 1
end

# Group && Upper-Intermediate
30.times do
  student_list << Student.new({
                                student_id: student_count,
                                delivery_mode: 'Group',
                                level: 'Upper-Intermediate',
                                timeslots: timeslot_list.sample(rand(1..5))
                              })
  student_count += 1
end

# Group && Advanced
30.times do
  student_list << Student.new({
                                student_id: student_count,
                                delivery_mode: 'Group',
                                level: 'Advanced',
                                timeslots: timeslot_list.sample(rand(1..5))
                              })
  student_count += 1
end

# Individual && Beginner
30.times do
  student_list << Student.new({
                                student_id: student_count,
                                delivery_mode: 'Individual',
                                level: 'Beginner',
                                timeslots: timeslot_list.sample(rand(1..5))
                              })
  student_count += 1
end

# Individual && Pre-Intermediate
30.times do
  student_list << Student.new({
                                student_id: student_count,
                                delivery_mode: 'Individual',
                                level: 'Pre-Intermediate',
                                timeslots: timeslot_list.sample(rand(1..5))
                              })
  student_count += 1
end

# Individual && Intermediate
30.times do
  student_list << Student.new({
                                student_id: student_count,
                                delivery_mode: 'Individual',
                                level: 'Intermediate',
                                timeslots: timeslot_list.sample(rand(1..5))
                              })
  student_count += 1
end

# Individual && Upper-Intermediate
30.times do
  student_list << Student.new({
                                student_id: student_count,
                                delivery_mode: 'Individual',
                                level: 'Upper-Intermediate',
                                timeslots: timeslot_list.sample(rand(1..5))
                              })
  student_count += 1
end

# Individual && Advanced
30.times do
  student_list << Student.new({
                                student_id: student_count,
                                delivery_mode: 'Individual',
                                level: 'Advanced',
                                timeslots: timeslot_list.sample(rand(1..5))
                              })
  student_count += 1
end
