# frozen_string_literal: true

require_relative 'lib/student.rb'
require_relative 'lib/teacher.rb'
require_relative 'lib/timeslot.rb'
require_relative 'lib/tentative_courses_builder.rb'

# Timeslots:
timeslot_list = []
timeslot_list = Timeslot.build_unique_timeslots

# Create teachers:
teacher_list = []
teacher_count = 1

25.times do
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
100.times do
  student_list << Student.new({
                                student_id: student_count,
                                delivery_mode: 'Group',
                                level: 'Beginner',
                                timeslots: timeslot_list.sample(rand(1..5))
                              })
  student_count += 1
end

# Group && Pre-Intermediate
100.times do
  student_list << Student.new({
                                student_id: student_count,
                                delivery_mode: 'Group',
                                level: 'Pre-Intermediate',
                                timeslots: timeslot_list.sample(rand(1..5))
                              })
  student_count += 1
end

# Group && Intermediate
100.times do
  student_list << Student.new({
                                student_id: student_count,
                                delivery_mode: 'Group',
                                level: 'Intermediate',
                                timeslots: timeslot_list.sample(rand(1..5))
                              })
  student_count += 1
end

# Group && Upper-Intermediate
100.times do
  student_list << Student.new({
                                student_id: student_count,
                                delivery_mode: 'Group',
                                level: 'Upper-Intermediate',
                                timeslots: timeslot_list.sample(rand(1..5))
                              })
  student_count += 1
end

# Group && Advanced
100.times do
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

tentative_courses_builder = TentativeCoursesBuilder.new({ student_list: student_list, teacher_list: teacher_list, timeslot_list: timeslot_list })
tentative_courses = tentative_courses_builder.tentative_courses

# tentative_courses.each do |tentative_course|
#   puts tentative_course.to_s
# end
puts tentative_courses.first.to_s
puts tentative_courses.first.timeslot
puts "---"
puts tentative_courses.first.students.count
puts tentative_courses.first.students.collect(&:timeslots)
