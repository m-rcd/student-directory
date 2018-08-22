def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  students = []

  name = gets.chomp

  while !name.empty? do
    students << student_info(name)
    puts "Now we have #{students.count} students"
    puts "Please enter another student"
    name = gets.chomp
  end
  students
end

def student_info(name)
  puts "Please enter their hobbies"
  hobbies = gets.chomp
  puts "Please enter their country of birth"
  country_of_birth = gets.chomp
  puts "Please enter their height"
  height = gets.chomp
  student = {name: name, cohort: :november, hobbies: hobbies, country_of_birth: country_of_birth, height: height}
    return student
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------".center(30)
end

def print(students)
  i = 0
  until i == students.length
    puts "#{students[i][:name]} (#{students[i][:cohort]} cohort), hobbies: #{students[i][:hobbies]}, country of birth: #{students[i][:country_of_birth]}, height: #{students[i][:height]}"
    i += 1
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students "
end

students = input_students
print_header
print(students)
print_footer(students)
