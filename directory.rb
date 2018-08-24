def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  students = []

  name = gets.chomp

  while !name.empty? do
    students << student_info(name)
    if students.count == 1
      puts "Now we have 1 student"
    else
      puts "Now we have #{students.count} students"
    end
    puts "Please enter another student"
    name = gets.chomp
  end
  students
end

def student_info(name)
  puts "Please enter their cohort"
  cohort = gets.chomp.to_sym
  if cohort == ""
    cohort = "november"
  end
  puts "Please enter their hobbies"
  hobbies = gets.chomp
  puts "Please enter their country of birth"
  country_of_birth = gets.chomp
  puts "Please enter their height"
  height = gets.chomp
  student = {name: name, cohort: cohort, hobbies: hobbies, country_of_birth: country_of_birth, height: height}
  if !student.empty?
    return student
  end

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

def interactive_menu
  students = []
  loop do
    puts "1. Input the students"
    puts "2. Show the students"
    puts "9. Exit"
    selection = gets.chomp
    case selection
      when "1"
        students = input_students
      when "2"
        print_header
        print(students)
        print_footer(students)
      when "9"
        exit
      else
        puts "I don't know what you meant, try again"
      end
    end
  end

interactive_menu
