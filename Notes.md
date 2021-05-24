<ins>Student model</ins>

### Initialize with:
- 1 valid delivery_mode
- 1 valid level
- list of timeslots
- 1 allocated flag
- 1 unique student_id

### Validations:
- VALID_DELIVERY_MODES = %w[Individual Group]
- VALID_LEVELS = %w[Beginner Pre-Intermediate Intermediate Upper-Intermediate Advanced]
- Each timeslot is an instance of Timeslot

### Methods:
- student? -> check valid instance
- allocate -> change @allocated to true

<ins>Teacher model</ins>

### Initialize with:
- list of timeslots
- 1 unique teacher_id

### Validations:
- each timeslot is:
  { timeslot: timeslot, allocated: false }

### Methods:
- teacher? -> check valid instance

<ins>Timeslot model</ins>

### Initialize with:
- 1 valid day
- 1 valid time
- 1 unique timeslot_id
- list of available teachers

### Validations:
- VALID_DAYS = %w[Monday Tuesday Wednesday Thursday Friday]
- VALID_TIMES = (9..19).to_a
- Each teacher is an instance of Teacher

### Methods:
- self.build_unique_timeslots -> build all the possible timeslots
- timeslot? -> check valid instance
- valid_timeslot? -> check if timeslot is included in all the possible timeslots

<ins>Course model</ins>

### Initialize with:
- 1 valid teacher
- 1 valid delivery_mode
- 1 valid level
- 1 valid timeslot
- list of valid students

### Validations:
- Valid teacher - instance of teacher
- Valid delivery_mode
- Valid level
- Valid timeslot - instance of timeslot
- Valid list of students - instances of student
- If delivery_mode == 'Group' -> students.count <= 6
- If delivery_mode == 'Individual' -> students.count <= 1

### Methods:
- valid_teacher?
- valid_timeslot?
- valid_student_list?

<ins>TentativeCourses model</ins>

### Initialize with:
- list of valid teachers
- list of valid students
- list of valid timeslots

### Methods

- assign_teacher_to_timeslot
- sort_student_list_by_id #first_come_first_served by chronological id number
- group_students_by_timeslot
- group_students_by_level_and_delivery_mode
- prioritize_groups --> first delivery_mode: 'group', then 'individual'. Between 'group': maximize number_of_students * weight (each level has an assigned weight
- delete_already_allocated_students_from_level_groups_hash
- build_tentative_courses


students_allocation_hash = {
  'Beginner' => {
    'students' => {
      'Group' => [],
      'Individual' => []
    },
    'weigth' => 100
  },
  'Pre-Intermediate' => {
    'students' => {
      'Group' => [],
      'Individual' => []
    },
    'weigth' => 200
  },
  'Intermediate' => {
    'students' => {
      'Group' => [],
      'Individual' => []
    },
    'weigth' => 300
  },
  'Upper-Intermediate' => {
    'students' => {
      'Group' => [],
      'Individual' => []
    },
    'weigth' => 400
  },
  'Advanced' => {
    'students' => {
      'Group' => [],
      'Individual' => []
    },
    'weigth' => 500
  }
}
