```ruby
# student.rb

# 1 delivery_mode
# 1 level
# timeslots (list)

# allocated

# --------------------

# teacher.rb

# timeslots (list)

# allocated

# --------------------

# tentative_course.rb

# init -> delivery_mode, level, timeslot

# 1 teacher
# 1 level
# 1 tiemslot
# students

# allocate_student(delivery_mode, level, timeslots)
# allocate_teacher(timeslots)

# self.levels
# self.delivery_modes

# max_capacity
# min_capacity

# list_of_course -> all

# --------------------

# timeslot.rb

# day
# time

```
