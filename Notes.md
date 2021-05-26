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
- to_s -> display course

----------------------------------------------------------------

<ins>Tentative courses builder</ins>

### Initialize with:

- student_list
- teacher_list
- timeslot_list
- available_timeslots (from teachers manager)
- unavailable_timeslots (optional)(from teachers manager)
- students_grouped_by_timeslot_level_and_delivery_mode (from students manager)
- tentative_courses -> build tentative courses

### Methods:
- build_tentantive_courses
- unallocated_students -> check unallocated students
- update_teacher_timeslot_status
- delete_already_allocated_students_from_level_groups_hash
- prioritize_level_groups

<ins>Teachers Manager</ins>

### Initialize with:

- teacher_list -> from builder
- timeslots_list -> from builder
- available_timeslots -> assign teacher to timeslot

### Methods:

- assign_teacher_to_timeslot

<ins>Students Manager</ins>

### Initialize with:

- student_list -> from builder
- available_timeslots -> from builder
- students_grouped_by_timeslot -> group_students_by_timeslot
- students_grouped_by_timeslot_level_and_delivery_mode -> group_students_by_level_and_delivery_mode

### Methods

- group_students_by_timeslot
- group_students_by_level_and_delivery_mode
- group_students_by_level
- group_students_by_delivery_mode
- build_allocation_hash

### Pseudocoding

1 - Iterate over each timeslot and assign all the available teachers to it. (teachers_manager)

2 - Return @available_timeslots --> a list of all the timeslots that has one or more available teachers ```teacher_timeslot[:allocated] == false```. Return @unavailable_timeslots --> there is no available teacher for these timeslots.
(teachers_manager)

3.0 - Order students by id.(students_manager)

3.1 - Group all the students by timeslot.(students_manager)

4 - Return @students_grouped_by_timeslot --> a list of unique students that could be assigned to a course. The remaining students did not choose any available timeslots.(students_manager)

5 - Group students by level and by delivery mode in each timeslot.(students_manager)

6 - Return @students_grouped_by_timeslot_level_and_delivery_mode --> a students allocation hash with the structure (see below) (students_manager)

```ruby
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
```

7 - Iterate over each timeslot of @students_grouped_by_timeslot_level_and_delivery_mode each (tentative_courses_manager)
  7.0 - Check if there is any available teacher for this timeslot.
  7.1 - In each level_groups_hash: delete already allocated students: ```student.allocated == true```
  7.2 - Prioritize levels: maximize function = number_of_students * weigth_of_level (weigth of level is an arbitrary number assigned to each level which represents the price each student pays for the course, this price is greater for the advanced courses). Also, 'Group' courses will have priority over individual courses.
  7.3 - Return ```prioritized_level_array```

8 - Iterate over each prioritized_level(tentative_courses_manager)
  8.0 - Check if there is still any available teacher for this timeslot.
    8.1 - If so, check if there is still any 'group' level unallocated.
      8.3 - If so,  a- Create tentative course with max 6 from the group (ordered by id: first in, first served), the first available teacher(first teacher of the updated list of teachers), the course level, timeslot(iteration) and delivery_mode.
                    b- Update_teacher_timeslot_status -> update teacher_timeslot status to ```teacher_timeslot[:allocated] == true``` and update available_teachers list in timeslot (remove the allocated teacher from the list)
    8.4 - Once all the 'group' level are been assigned a teacher, do the same with 'individual' students if there is any available teacher. The difference is each course will have only 1 student.
