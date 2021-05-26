# frozen_string_literal: true

require_relative '../lib/course.rb'
require_relative '../lib/student.rb'
require_relative '../lib/teacher.rb'
require_relative '../lib/timeslot.rb'
require_relative '../lib/tentative_courses_builder.rb'

shared_context 'student, teacer, timeslot and tentative courses instances' do
  before do
    # Timeslots:
    @timeslot_list = []
    @timeslot_list = Timeslot.build_unique_timeslots

    # Create teachers:
    @teacher_list = []
    teacher_count = 1

    25.times do
      timeslots = []
      rand(1..25).times do
        timeslots << { timeslot: @timeslot_list.sample, allocated: false }
      end
      @teacher_list << Teacher.new(teacher_id: teacher_count, timeslots: timeslots.uniq)
      teacher_count += 1
    end

    # Create students:
    @student_list = []
    student_count = 1

    # Group && Beginner
    30.times do
      @student_list << Student.new(
        {
          student_id: student_count,
          delivery_mode: 'Group',
          level: 'Beginner',
          timeslots: @timeslot_list.sample(rand(1..5))
        }
      )
      student_count += 1
    end

    # Group && Pre-Intermediate
    30.times do
      @student_list << Student.new(
        {
          student_id: student_count,
          delivery_mode: 'Group',
          level: 'Pre-Intermediate',
          timeslots: @timeslot_list.sample(rand(1..5))
        }
      )
      student_count += 1
    end

    # Group && Intermediate
    30.times do
      @student_list << Student.new(
        {
          student_id: student_count,
          delivery_mode: 'Group',
          level: 'Intermediate',
          timeslots: @timeslot_list.sample(rand(1..5))
        }
      )
      student_count += 1
    end

    # Group && Upper-Intermediate
    30.times do
      @student_list << Student.new(
        {
          student_id: student_count,
          delivery_mode: 'Group',
          level: 'Upper-Intermediate',
          timeslots: @timeslot_list.sample(rand(1..5))
        }
      )
      student_count += 1
    end

    # Group && Advanced
    30.times do
      @student_list << Student.new(
        {
          student_id: student_count,
          delivery_mode: 'Group',
          level: 'Advanced',
          timeslots: @timeslot_list.sample(rand(1..5))
        }
      )
      student_count += 1
    end

    # Individual && Beginner
    30.times do
      @student_list << Student.new(
        {
          student_id: student_count,
          delivery_mode: 'Individual',
          level: 'Beginner',
          timeslots: @timeslot_list.sample(rand(1..5))
        }
      )
      student_count += 1
    end

    # Individual && Pre-Intermediate
    30.times do
      @student_list << Student.new(
        {
          student_id: student_count,
          delivery_mode: 'Individual',
          level: 'Pre-Intermediate',
          timeslots: @timeslot_list.sample(rand(1..5))
        }
      )
      student_count += 1
    end

    # Individual && Intermediate
    30.times do
      @student_list << Student.new(
        {
          student_id: student_count,
          delivery_mode: 'Individual',
          level: 'Intermediate',
          timeslots: @timeslot_list.sample(rand(1..5))
        }
      )
      student_count += 1
    end

    # Individual && Upper-Intermediate
    30.times do
      @student_list << Student.new(
        {
          student_id: student_count,
          delivery_mode: 'Individual',
          level: 'Upper-Intermediate',
          timeslots: @timeslot_list.sample(rand(1..5))
        }
      )
      student_count += 1
    end

    # Individual && Advanced
    30.times do
      @student_list << Student.new(
        {
          student_id: student_count,
          delivery_mode: 'Individual',
          level: 'Advanced',
          timeslots: @timeslot_list.sample(rand(1..5))
        }
      )
      student_count += 1
    end

    @tentative_courses_builder = TentativeCoursesBuilder.new({ student_list: @student_list, teacher_list: @teacher_list, timeslot_list: @timeslot_list })
    @tentative_courses = @tentative_courses_builder.tentative_courses
  end
end

describe Course do
  include_context 'student, teacer, timeslot and tentative courses instances'

  describe '#initialize' do
    it 'takes a hash of attributes as a parameter' do
      attributes = {
        teacher: @teacher_list.first,
        delivery_mode: 'Group',
        level: 'Beginner',
        timeslot: @timeslot_list.first,
        students: @student_list.sample(rand(1..6))
      }
      course = Course.new(attributes)
      expect(course).to be_a(Course)
    end

    it 'receives the :teacher attribute, which is an instance of Teacher' do
      attributes = { teacher: Teacher.new({}) }
      course = Course.new(attributes)
      expect(course.instance_variable_get(:@teacher)).to be_a(Teacher)
    end

    it 'receives the :timeslot attribute, which is an instance of Timeslot' do
      attributes = { timeslot: @timeslot_list.first }
      course = Course.new(attributes)
      expect(course.instance_variable_get(:@timeslot)).to be_a(Timeslot)
    end

    it 'receives the :level attribute, which should be one of: Beginner, Pre-Intermediate, Intermediate, Upper-Intermediate or Advanced' do
      attributes = { level: 'Beginner' }
      expect(attributes[:level]).to be_a String
      expect(VALID_LEVELS).to include(attributes[:level])
    end

    it 'receives the :delivery_mode attribute, which should be one of: Group or Individual' do
      attributes = { delivery_mode: 'Group' }
      expect(attributes[:delivery_mode]).to be_a String
      expect(VALID_DELIVERY_MODES).to include(attributes[:delivery_mode])
    end

    it 'receives the :students attribute, which is an array of instances of Student' do
      attributes = { student_list: @student_list.sample(rand(1..6)) }
      course = Course.new(attributes)
      expect(attributes[:student_list]).to all(be_a Student)
    end
  end

  it 'each tentative course should have a teacher of class Teacher' do
    expect(@tentative_courses).to all(respond_to :teacher)
    @tentative_courses.each do |tentative_course|
      expect(tentative_course.teacher).to be_a Teacher
    end
  end

  it 'each tentative course should have a level' do
    expect(@tentative_courses).to all(respond_to :level)
  end

  it 'each tentative course should have a delivery mode' do
    expect(@tentative_courses).to all(respond_to :delivery_mode)
  end

  it 'each tentative course should have a timeslot of class Timeslot' do
    expect(@tentative_courses).to all(respond_to :timeslot)
    @tentative_courses.each do |tentative_course|
      expect(tentative_course.timeslot).to be_a Timeslot
    end
  end

  it 'each tentative course should have a list of students' do
    expect(@tentative_courses).to all(respond_to :students)
    @tentative_courses.each do |tentative_course|
      tentative_course.students.each do |student|
        expect(student).to be_a Student
      end
    end
  end

  it 'each tentative course should respect the teacher availability' do
    @tentative_courses.each do |tentative_course|
      teacher_timeslots = []
      tentative_course.teacher.timeslots.each do |timeslot_hash|
        teacher_timeslots << timeslot_hash[:timeslot]
      end
      expect(teacher_timeslots).to include(tentative_course.timeslot)
    end
  end

  it 'each tentative course should respect the student availability' do
    @tentative_courses.each do |tentative_course|
      tentative_course.students.each do |student|
        expect(student.timeslots).to include(tentative_course.timeslot)
      end
    end
  end

  it "each tentative course's student should have the same level" do
    @tentative_courses.each do |tentative_course|
      students_level = []
      tentative_course.students.each do |student|
        students_level << student.level
      end
      expect(students_level.uniq.count).to be 1
    end
  end

  it "each tentative course's student should have the same delivery mode" do
    @tentative_courses.each do |tentative_course|
      students_delivery_mode = []
      tentative_course.students.each do |student|
        students_delivery_mode << student.delivery_mode
      end
      expect(students_delivery_mode.uniq.count).to be 1
    end
  end

  it "each 'Individual' tentative course should have at most 1 student" do
    individual_tcs = @tentative_courses.select{ |tc| tc.delivery_mode == 'Individual'}
    individual_tcs.each do |individual_tc|
      expect(individual_tc.students.count).to eq(1)
    end
  end

  it "each 'Group' tentative course should have at most 6 student" do
    individual_tcs = @tentative_courses.select{ |tc| tc.delivery_mode == 'Group'}
    individual_tcs.each do |individual_tc|
      expect(individual_tc.students.count).to be <= 6
    end
  end
end
